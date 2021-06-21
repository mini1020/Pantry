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

// セレクトボックスの値を取得
$(function() {
  $('#search_place').on("change", function() {
    var storage_id = document.getElementById('search_place').value;

    $.ajax({
      type: 'GET', // リクエストのタイプ
      url: '/users/:user_id/storages/foods/search', // リクエストを送信するURL
      data: { storage_id: storage_id }, // サーバーに送信するデータ。自動的にクエリ文字列に変換される
      dataType: 'json', // サーバーから返却される型
    })
    .done(function(data){
      // console.log(data);
      $('.table__foods-index').remove();

      $(data.foods).each(function(index, food) {
        $('tbody').append(
          `<tr class="table__foods-index">
            <td>${food.fname}</td>
            <td>${food.quantity}</td>
            <td>${food.purchase}</td>
            <td>${food.expiration}</td>
            <td>${data.storage.place}</td>
            <td>
              <a class="btn btn--edit btn--margin" data-remote="true" href="/users/${data.storage.user_id}/storages/${food.storage_id}/foods/${food.id}/edit">
                編集
              </a>
              <a data-confirm="削除してよろしいですか？" class="btn btn--destroy btn--margin" rel="nofollow" data-method="delete" href="/users/${data.storage.user_id}/storages/${food.storage_id}/foods/${food.id}">
                削除
              </a>
            </td>
          </tr>`
        );
      })
    })
  });
});