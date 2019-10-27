//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require jquery.slick
//= require_tree .

function deleteImage(id, type, image) {
    Swal.fire({
        title: 'Are you sure you want to delete this?',
        text: "It's not the end of the world if you do.",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#00a74e',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.value) {
            if (type == 'image') {
                $.ajax({
                    type: "GET",
                    url: "/images/delete/" + id,
                    success: function () {
                        $(image).remove();
                        $('body').append("<div class='alert admin-alerts alert-success alert-dismissible fade show' role='alert'>Image successfully deleted.</div>");
                    }
                });
            } else {
                $.ajax({
                    type: "GET",
                    url: "/slides/delete/" + id,
                    success: function () {
                        $(image).remove();
                        $('body').append("<div class='alert admin-alerts alert-success alert-dismissible fade show' role='alert'>Slide successfully removed.</div>");
                    }
                });
            }
        }
    })
}

function uploadImage(){
  $('.new-image').click(function(){
      $('#image_url').click();
  });

  $('#image_url').change(function() {
      $('#new-image-submit').click();
  });
}

$(document).ready(function(){
    $('.slider').slick({
        centerMode: true,
        variableWidth: true,
        slidesToScroll: 1,
        dots: true,
        speed: 1000,
        autoplay: true,
        autoplaySpeed: 2000,
        dots: true,
    })
});

$(document).ready(function() {
    $('.email-button').click(function(){
        if($('#fname').val() != "" && $('#lname').val() != "" && $('#email').val() != "" && $('#body').val() != "") {
            $.ajax({
                type: "GET",
                url: "/contacts/new",
                success: function() {
                    Swal.fire(
                        'Thanks for the message!',
                        "We'll get back to you as soon as we can!",
                        'success'
                    )
                    $('#name').val("");
                    $('#email').val("");
                    $('#body').val("");
                }
            });
        } else {
            if($('#fname').val() == "" || $('#lname').val() == ""){
                Swal.fire({
                    type: 'error',
                    title: 'Oops...You forgot to give us your name',
                    text: 'Please make sure you fill in the first and last name fields.'
                })
            } else if($('#email').val() == ""){
                Swal.fire({
                    type: 'error',
                    title: 'Oops...You forgot to give us your email',
                    text: 'Please make sure you fill in the email field.'
                })
            } else if($('#body').val() == ""){
                Swal.fire({
                    type: 'error',
                    title: 'Oops...You forgot to give us a message',
                    text: 'Please make sure you fill in the message field.'
                })
            }
        }
    })
});

//smooth scrolling from within same page
$(document).ready(function(){
var path = window.location.pathname;

  if(path.indexOf("gallery") < 0 && path.indexOf("panel") < 0){

    $('#home-link').click(function(){
      $("html, body").animate({ scrollTop: 0}, 600);
    });

    $('#about-link').click(function(){
      $("html, body").animate({ scrollTop: $('#about').offset().top - 140}, 600);
    });

    $('#services-link').click(function(){
      $("html, body").animate({ scrollTop: $('#service').offset().top - 140}, 600);
    });

    $('#contact-us-link').click(function(){
      $("html, body").animate({ scrollTop: $('#contact-us').offset().top - 140}, 600);
    });

      $('.cover-overlay-button').click(function(){
        $("html, body").animate({ scrollTop: $('#contact-us').offset().top - 140}, 600);
      });

      $('#jumbotron-button-contact-us').click(function(){
        $("html, body").animate({ scrollTop: $('#contact-us').offset().top - 140}, 600);
      });

      $('#jumbotron-button-services').click(function(){
        $("html, body").animate({ scrollTop: $('#service').offset().top - 140}, 600);
      });

      $('#jumbotron-button-gallery').click(function(){
        window.location.href = "/gallery";
      });
    }
})

$(document).ready(function(){
    $('#topheader .navbar-nav a').on('click', function() {
        $('#topheader .navbar-nav').find('li.active').removeClass('active');
        $(this).parent('li').addClass('active');
    });
})

$(document).ready(function(){
    var path = window.location.pathname;
    if(path.indexOf("gallery") >= 0 || path.indexOf("panel") >= 0){
        $('#gallery-link').parent('li').addClass('active');

        $('#home-link').click(function(){
          window.location.href = "/";
        });

        $('#about-link').click(function(){
          window.location.href = "/#about-us";
        });

        $('#services-link').click(function(){
          window.location.href = "/#services";
        });

        $('#contact-us-link').click(function(){
          window.location.href = "/#contact-us";
        });
    }
})

//adjust modal to show larger image
$(document).ready(function () {
    $('.image-container img').click(function(){
        $('.modal-content img').remove();
        var image = $(this).attr('src');
        var imageHtml = '<img src="' + image + '">';
        $('.modal-content').append(imageHtml);
        $('#modal').css("display", "block");
        if($('.modal-content img').height() > window.innerHeight - 200 && window.innerHeight < window.innerWidth){
            var naturalHeight = $(this).height();
            var naturalWidth = $(this).width();
            var adjustedHeight = window.innerHeight - 200 - 150;
            var ratio = adjustedHeight / naturalHeight;
            $('.modal-content img').css('max-height', adjustedHeight);
            $('.modal-content').css('width', naturalWidth * ratio);
            $('.modal-content').css('min-height', '150px');
        } else {
            $('.modal-content img').css('max-width', '100%');
            $('.modal-content').css('min-height', '150px');
        }
        $('.close').click(function(){
            $('#modal').css("display", "none");
            $('.modal-content').css('width', '');
        })
    })
});

//homepage fade in
$(document).ready(function(){
  $('.cover-image').hide();
  $('.cover-overlay').hide();
  $('.cover-overlay').fadeIn(1500);
  $('.cover-image').fadeIn(1500);
});

$(document).ready(function(){
  var screenHeight = window.innerHeight - 127;
  var screenWidth = window.innerWidth;
  $('.cover-image').css('height', screenHeight);
  if($('.cover-image').width() < screenWidth){
    $('.cover-image').css('width', '100%');
  }
});

$(document).ready(function(){
  $('#custom-button-gallery').click(function(){
    window.location.href = "/gallery";
  });

  $('#custom-button-home').click(function(){
    window.location.href = "/";
  });
});

$(document).ready(function(){
  var path = window.location.href;
  if(path.indexOf("#about-us") >= 0){
    $('#about-link').parent('li').addClass('active');
    $("html, body").animate({ scrollTop: $('#about').offset().top - 140}, 600);
  }

  if(path.indexOf("#services") >= 0){
    $('#services-link').parent('li').addClass('active');
    $("html, body").animate({ scrollTop: $('#service').offset().top - 140}, 600);
  }

  if(path.indexOf("#contact") >= 0){
    $('#contact-us-link').parent('li').addClass('active');
    $("html, body").animate({ scrollTop: $('#contact-us').offset().top - 140}, 600);
  }

});
