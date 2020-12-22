jQuery(document).ready( function( $ ) {

  var navBarDesktopHeight = $('.navbar-desktop').innerHeight(),
      navBarMobileHeight = $('.navbar-mobile').innerHeight(),
      firstNewsLetterInputHeight = $('.first-side .widget-content input[type="email"]').outerHeight(),
      secondNewsLetterInputHeight = $('.second-side .widget-content input[type="email"]').outerHeight(),
      serviceBoxElement = $('.our-work .service-box'),
      serviceBoxActiveElement = $('.our-work .service-box.active'),
      servicesHeight = $('.services').outerHeight(),
      is_rtl = $('head').attr('dir') == 'rtl' ? true : false;


  // Contact Us Landing Page
  $('.landing_page_contact_button').click( function (e) {
    e.preventDefault();
    window.location.href = '/home#contact-us';
  });

  // Desktop and mobile styles
  if ($(window).outerWidth() >= '768') {
    $('.services').find('.container').css('transform', 'translateY(' + (navBarDesktopHeight + 75) + 'px)');
    $('#primary').css('padding-top', (navBarDesktopHeight + 50) + 'px');
    $('#primary-about-us').css('padding-top', (navBarDesktopHeight + 50) + 'px');
    $('.first-side .widget-content input[type="submit"]').css('height', firstNewsLetterInputHeight + 'px');
  } else {
    $('.services').find('.container').css('transform', 'translateY(' + (navBarMobileHeight + 40) + 'px)');
    $('#primary').css('padding-top', (navBarMobileHeight + 25) + 'px');
    $('#primary-about-us').css('padding-top', (navBarMobileHeight + 25) + 'px');
    $('.second-side .widget-content input[type="submit"]').css('height', secondNewsLetterInputHeight + 'px');
  }

  // Service Box Background
  serviceBoxElement.hover( function () {
    $(this).css('background', $(this).css('border-color') ).find('a').css('color', '#fff');
  }, function () {
    $(this).css('background', 'transparent').find('a').css('color', '#000');;
  });

  // Service Box If Has Active Class
  if (serviceBoxElement.hasClass('active')) {
    serviceBoxActiveElement.css('background', serviceBoxActiveElement.css('border-color') ).find('a').css('color', '#fff');
  }



  // Our Project style class in Home Page
  $('.our-projects .project-content').map(function (e, k) {
    var childId = '#' + k.getAttribute('id');
    if (e == 0) {
      $(childId).find('.first_image').addClass('d-none');
      $(childId).find('.arrow_image').removeClass('px-0 text-center');
      $(childId).find('.second_image').removeClass('d-none');
    } else {
      $(childId).find('.first_image').removeClass('d-none');
      // $(childId).find('.arrow_image').removeClass('px-0 text-center');
      $(childId).find('.second_image').addClass('d-none');
    }

  });


  // $(window).scroll(function () {
  //   if ($(this).scrollTop() > 80) {
  //     $('.navbar-desktop').css('background-color', 'rgb(0 12 44)');
  //   } else {
  //     $('.navbar-desktop').css('background-color', 'transparent');
  //   }
  // });
  // Contact Us Smoth Scroll
  $('.contact_us_link').on('click', function (e) {
    e.preventDefault();
    $('html, body').animate({
      scrollTop: $('#contact-us').offset().top
    }, 1000);
  });

  // Footer Menu For Bootstrap Grid
  $('.footer_menu').find('li').addClass('col-6 mb-3').find('a').addClass('footer-nav-item');



  // Show Service Content When Hover
  $('.service-slide-box').hover( function () {
    var PElement = $(this).find('p');
    if (PElement.text() != '') {
      $(this).parents('.services').css('height', servicesHeight);
      $(this).find('h4').slideUp();
      PElement.slideDown();
      $(this).parents('.services').css('height', $(this).parents('.services').innerHeight() + ($(this).height() * 0.75) + 'px');
    }
  }, function () {
    var PElement = $(this).find('p');
    if (PElement.text() != '') {
      $(this).find('h4').slideDown();
      PElement.slideUp();
      $(this).parents('.services').css('height', servicesHeight);
      // $(this).parents('.services').css('height', $(this).parents('.services').innerHeight() - ($(this).height() * 0.75) + 'px');
    }
  });


  /* Contact From Submission */
  $('#yesUserContactForm').on('submit', function (e) {
    // Prevent Form Submit Default
    e.preventDefault();

    $('.has-error').removeClass('has-error');
    $('.js-show-feedback').removeClass('js-show-feedback');

    var form    = $(this),
      name    = form.find('#name').val(),
      email   = form.find('#email').val(),
      message = form.find('#message').val(),
      ajaxurl = form.data('url');

    // Check In Javascript Also To Prevent The Progress If The Fields Is Empty
    if( name === '' ) {
      form.find('#name').parent('.footer-input').addClass('has-error');
      return;
    }

    if( email === '' ) {
      $('#email').parent('.footer-input').addClass('has-error');
      return;
    }

    if( message === '' ) {
      $('#message').parent('.footer-input').addClass('has-error');
      return;
    }

    form.find('input, button, textarea').attr('disabled','disabled');
    $('.js-form-submission').addClass('js-show-feedback');

    // Ajax Function
    $.ajax({
      url : ajaxurl,
      type : 'post',
      data : {
        name : name,
        email : email,
        message : message,
        action: 'yes_user_save_user_contact_form'
      },
      error : function( response ) {
        $('.js-form-submission').removeClass('js-show-feedback');
        $('.js-form-error').addClass('js-show-feedback');
        form.find('input, button, textarea').removeAttr('disabled');
      },
      success : function( response ) {
        // if the response equal to zero that mean the request was not successfully done and not recording into database
        if( response == 0 ) {
          setTimeout(function(){
            $('.js-form-submission').removeClass('js-show-feedback');
            $('.js-form-error').addClass('js-show-feedback');
            form.find('input, button, textarea').removeAttr('disabled');
          },1500);
        } else {
          setTimeout(function() {
            $('.js-form-submission').removeClass('js-show-feedback');
            $('.js-form-success').addClass('js-show-feedback');
            form.find('input, button, textarea').removeAttr('disabled').val('');
          },1500);
        }
      } // success function
    }); // ajax
  }); // submit function


  // blog page add grid bootstrap classes
  $('#primary .blog-main .blog-posts .row').children().map(function (e, k) {
    var childId = '#' + k.getAttribute('id');
    if (e == 0) {
      if ($(childId).find('.time-parent-box').find('span').is('.read_time')) {
        $(childId).addClass('col-12')
          .find('.time-parent-box').addClass('col-6 col-md-5 col-lg-4 text-right').find('.read_time').removeClass('pull-right').addClass('d-block')
          .parent('.time-parent-box')
          .siblings('.category-parent-box').addClass('col-6 col-md-7 col-lg-8')
          .find('.category-box').addClass('border-green-blue mb-2');
      } else {
        $(childId).addClass('col-12')
          .find('.time-parent-box').addClass('col-6 col-md-5 col-lg-4 text-right')
          .siblings('.category-parent-box').addClass('col-6 col-md-7 col-lg-8')
          .find('.category-box').addClass('border-green-blue mb-2');
      }
    } else {
      $(childId).addClass('col-6')
        .find('.time-parent-box').addClass('col-12 mt-lg-2')
        .siblings('.category-parent-box').addClass('col-12')
        .find('.category-box').addClass('border-bing mb-2');
    }
  });


  // Slick In Our Work Page
  $('.our-work-filter-slick').slick({
    dots: false,
    arrows: false,
    infinite: true,
    speed: 300,
    rtl: is_rtl,
    slidesToShow: 1,
    centerMode: true,
    variableWidth: true
  });


  // Typed In Landing Page
  var typed3 = new Typed('#typed', {
    stringsElement: '#typed-header-strings',
    // strings: ['Say Yes To: ...', 'Say Yes To: Creative', 'Say Yes To: Magnate', '', 'Say Yes To: Yes User'],
    typeSpeed: 50,
    backSpeed: 50,
    cursorChar: '',
    smartBackspace: true, // this is a default
    loop: true
  });




});
