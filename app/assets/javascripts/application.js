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
//= require jquery3
//= require rails-ujs
//= require jquery-ui
//= require tag-it
//= require popper
//= require bootstrap-sprockets

//= require chartkick
//= require Chart.bundle

//= require activestorage

//= require_tree .
/*global $*/

/*********トップメニューバー****/
$(function() {
  $("ul.menu li").hover(
    function() {
      $(".menuSub:not(:animated)", this).slideDown();
    },
    function() {
      $(".menuSub", this).slideUp();
    }
  );
});

/************マイページメニューバー***********/
$(function() {
  $("ul.user-menu li").hover(
    function() {
      $(".child", this).slideDown();
    },
    function() {
      $(".child", this).slideUp();
    }
  );
});



/**********複数画像スライダー***********/
$(function() {
    $('.slider').slick({
        dots: true,
    });
});

/*一枚ならドットなし*/
$(function() {
    $('.slider__solo').slick({});
});


/***************マイページ　写真ソート選択動化*/
$(function(){
    $('#sort').change(function() {
        $(".select form").submit();
    });
});