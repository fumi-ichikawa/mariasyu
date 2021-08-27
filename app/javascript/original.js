  $(function() {
    $('.mariage__image').slick({
      slidesToShow: 1,//スライドを画面に3枚見せる
      slidesToScroll: 1,//1回のスクロールで3枚の写真を移動して見せる
      pauseOnFocus: false,//フォーカスで一時停止を無効
      pauseOnHover: false,//マウスホバーで一時停止を無効
      pauseOnDotsHover: false,//ドットナビゲーションをマウスホバーで一時停止を無効
      centerMode: true,
      centerPadding: '5%',
      dots: true,
      autoplay: true,
      autoplaySpeed: 3000,
      speed: 1000,
      infinite: true,
    });
  });
  