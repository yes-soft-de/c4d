<?php


namespace App\Service;


use App\Request\SettingRequest;
use App\Response\SettingResponse;
use DateTime;
use Exception;
use Gedmo\Sluggable\Util\Urlizer;
use League\Flysystem\FileNotFoundException;
use League\Flysystem\FilesystemInterface;
use Liip\ImagineBundle\Service\FilterService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\HttpFoundation\File\UploadedFile;

class UploadFileService
{
    private $filterService;
    private $fileSystem;
    private $params;
    private $settingService;

    public function __construct(FilesystemInterface $fileSystem, FilterService $filterService, ParameterBagInterface $params,
                                SettingService $settingService)
    {
        $this->filterService = $filterService;
        $this->fileSystem = $fileSystem;
        $this->params = $params;
        $this->settingService = $settingService;
    }

    public function uploadImage(UploadedFile $uploadedFile, ?string $existingFileName): string
    {
        $subFolder = $this->subFolder();

        $path = $this->getImageDestinationPath().'/'.$subFolder.'/';

        $originalFileName = pathinfo($uploadedFile->getClientOriginalName(), PATHINFO_FILENAME);

        $newFileName = Urlizer::urlize($originalFileName) . '-' . uniqid() . '.' . $uploadedFile->guessExtension();

        $stream = fopen($uploadedFile->getPathname(), 'r');

        $result = $this->fileSystem->writeStream($path . $newFileName, $stream);

        if ($result === false)
        {
            throw new Exception(sprintf('Could not write uploaded file "%s"', $newFileName));
        }

        if (is_resource($stream))
        {
            fclose($stream);
        }

        if ($existingFileName)
        {
            try {
                $result = $this->fileSystem->delete($path . $existingFileName);

                if ($result === false)
                {
                    throw new Exception(sprintf('Could not delete old file "%s"', $existingFileName));
                }
            } catch (FileNotFoundException $e) {

            }
        }

        //$resolve = $this->filterService->getUrlOfFilteredImage($subFolder.'/'.$newFileName, 'basic');

        return $path . $newFileName;
    }

    public function getImageDestinationPath(): string
    {
        $imageFolder = $this->params->get('image_folder');
        $originalImageFolder = $this->params->get('original_image');

        $destination = $imageFolder.'/'.$originalImageFolder;

        return $destination;
    }

    public function subFolder(): string
    {
        $count = rand(1, 10);

        if ($count == 10)
        {
            $newFolderName = $this->newFolderName();

            $this->updateCurrentSubFolder($newFolderName);

            return $newFolderName;
        }
        else
        {
            return $this->getCurrentSubFolder();
        }
    }

    public function getCurrentSubFolder(): string
    {
        $subFolder = $this->settingService->getSetting();

        /* @var $subFolder SettingResponse */
        if ($subFolder)
        {
            return $subFolder->uploadSubFolder;
        }
        else
        {
            $result = $this->newFolderName();
            $this->createSetting($result);

            return $result;
        }
    }

    public function newFolderName(): string
    {
        $datetime = new DateTime();
        $folderName = $datetime->format('Y-m-d_H-i-s');

        return $folderName;
    }

    public function updateCurrentSubFolder($newFolderName)
    {
        $request = new SettingRequest();

        $request->setUploadSubFolder($newFolderName);

        $this->settingService->saveSetting($request);
    }

    public function createSetting($newFolderName)
    {
        $request = new SettingRequest();

        $request->setUploadSubFolder($newFolderName);

        $this->settingService->createSetting($request);
    }

}
