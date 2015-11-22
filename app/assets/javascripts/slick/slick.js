$(document).ready(function(){
      $('.image-carousel').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 2000,
        centerMode: true,
        centerPadding: '500px',
        responsive: [
          {
            breakpoint: 1440,
            settings: {
              slidesToShow: 3,
              slidesToScroll: 1,
              centerMode: false,
            }
          },
          // {
          //   breakpoint: 1024,
          //   settings: {
          //     slidesToShow: 3,
          //     slidesToScroll: 1,
          //     centerMode: false,
          //   }
          // },
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
