import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel

    //現在開いているページのURLをゲット
    let url = window.location.href
    //スラッシュ(/)ごとに要素を取り出す
    let param = url.split('/');
    //このアプリの場合、URLの一番最後にアイテムidがきており、それをparamItemとして定義
    let paramItem = param[param.length-1]
    // パラメータid(URLの中に含まれているid)が、コントローラーから送った`data.id`かどうかを判断する
    if (paramItem == data.id) {

      const comments = document.getElementById('comments');
      const comment = document.getElementsByClassName('comment-display');
      const textElement = document.createElement('div');
      textElement.setAttribute('class', "comment-display");

      const topElement = document.createElement('div');
      topElement.setAttribute('class', "comment-top");

      const nameElement = document.createElement('div');
      const timeElement = document.createElement('div');

      const bottomElement = document.createElement('div');
      bottomElement.setAttribute('class', "comment-bottom");

      comments.insertBefore(textElement, comments.firstElementChild);
      textElement.appendChild(topElement);
      textElement.appendChild(bottomElement);
      topElement.appendChild(nameElement);
      topElement.appendChild(timeElement);

      const name = `${data.nickname}`;
      nameElement.innerHTML = name;
      const time = `${data.time}`;
      timeElement.innerHTML = time;
      const text = `<p>${data.content.text}</p>`;
      bottomElement.innerHTML = text;

      const newComment = document.getElementById('comment_text');
      newComment.value='';

      const inputElement = document.querySelector('input[name="commit"]');
      inputElement.disabled = false;
    }
  }
});
