import consumer from "./consumer"

consumer.subscriptions.create("AnswersChannel", {
  connected() {
    this.perform('follow', { question_id: gon.params['id'] })
  },

  received(data) {
    if (!(gon.user_id === data.answer.user_id)) {
      $(".answers").append(JST['templates/answer']({answer: data.answer, rating: data.rating}));
    }
  }
});