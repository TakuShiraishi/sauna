// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"



import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'
import "./jquery.jpostal.js"
// jquery.jpostal.jsこの記述追加
   $(document).on('turbolinks:load' ,() => {
       $('#sauna_post_code').jpostal({
            postcode : [
              '#sauna_post_code'
            ],
        address:{
            "#sauna_prefecture": "%3", // # 都道府県が入力される
            "#sauna_place"           : "%4%5", // # 市区町村と町域が入力される
            "#sauna_address"         : "%6%7" // # 大口事務所の番地と名称が入力される
        }
      });
   });



Rails.start()
Turbolinks.start()
ActiveStorage.start()

import Raty from "../src/raty.js"
window.raty = function(elem,opt){
    var raty =  new Raty(elem,opt)
    raty.init();
    return raty;
}


