// attr()→HTML要素の属性の取得や設定ができるメソッド
$(function() {
  $('#btn__destroy--request').attr('disabled', 'disabled');
  $('#checkbox__agree').on("click", function() {
    // prop()→input関連の値が取得できるメソッド
    if ( $(this).prop('checked') == false ) {
      $('#btn__destroy--request').attr('disabled', 'disabled');
    }
    else {
      // remobeAttr→HTMLの属性を削除するメソッド
      // disabled = "disabled"を丸ごと削除
      $('#btn__destroy--request').removeAttr('disabled');
    }
  });
});