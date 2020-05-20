// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require chartkick
//= require Chart.bundle
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

document.addEventListener("turbolinks:load", function() {

  $(document).ready(function() {
    $('#open_nav').on('click', function() {
        $('#wrapper, #naver').toggleClass('show');
    });
  });

  // 画像プレビュー
  $(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
    $('#img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $("#user_img").change(function(){
        readURL(this);
    });
  });
// 画像プレビュー2
  $(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
    $('#img_two').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $("#style_two").change(function(){
        readURL(this);
    });
  });
// 画像プレビュー3
  $(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
    $('#img_three').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $("#style_three").change(function(){
        readURL(this);
    });
  });

  // const thumbs = document.querySelectorAll('.thumb');
  // thumbs.forEach(function(item, index) {
  //   item.onclick = function() {
  //     document.getElementById('bigimg').src = this.dataset.image;
  //   }
  // });

  $(function() {
  $('.imageList__thumbnail').on('click',function() {

    if ( $(this).hasClass("selected") ) {
        return;
    }

    var selectedImgSrc = $(this).children('img').attr('src');

    $('.selected').removeClass('selected');
    $(this).addClass('selected');

    $('.imageList__view').children('img').attr('src', selectedImgSrc);
  });
})


$(function(){
  $('.box img').addClass('move');
  $(window).scroll(function(){
    $(".box").each(function(){
      var imgPos = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + windowHeight/5){
        $(this).find("img").removeClass('move');
      } else {
        $(this).find("img").addClass('move');
      }
    });
  });
});


  $(document).ready(function () {
    $("#theTarget").skippr({
      // スライドショーの変化 ("fade" or "slide")
      transition : 'fade',
      // 変化に係る時間(ミリ秒)
      speed : 1000,
      // easingの種類
      easing : 'easeOutQuart',
      // ナビゲーションの形("block" or "bubble")
      navType : 'block',
      // 子要素の種類("div" or "img")
      childrenElementType : 'div',
      // ナビゲーション矢印の表示(trueで表示)
      arrows : true,
      // スライドショーの自動再生(falseで自動再生なし)
      autoPlay : true,
      // 自動再生時のスライド切替間隔(ミリ秒)
      autoPlayDuration : 5000,
      // キーボードの矢印キーによるスライド送りの設定(trueで有効)
      keyboardOnAlways : true,
      // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
      hidePrevious : false
    });
  });

})