$(document).ready(function(){
      $('.image-carousel').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        centerMode: true,
        centerPadding: '525px',
        autoplay: false,
        adaptiveHeight: true,
        responsive: [
          {
            breakpoint: 1440,
            settings: {
              slidesToShow: 1,
              centerMode: true,
              adaptiveHeight: true,

            }
          },
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1,
              fade: true,
              cssEase: 'linear'
            }
          },
          {
            breakpoint: 640,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1,
              fade: true,
              cssEase: 'linear'
            }
          },
        ]
      });
    });
