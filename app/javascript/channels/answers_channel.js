import consumer from "./consumer"

consumer.subscriptions.create("AnswersChannel", {
  connected() {
    this.perform('follow', { question_id: gon.params['id'] })
  },

  received(data) {
    if (!(gon.user_id === data.answer.user_id)) {
      let answerTemplate = require('/app/javascript/templates/answer.hbs')({
        answer: data.answer,
        question: data.question
      })

      $('.answers').append(answerTemplate)
    }
  }
});