import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    console.log(gon.params)
    console.log(gon.user_id)

    this.perform('follow', { question_id: gon.params['id'] })
  },

});