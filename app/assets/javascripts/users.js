var main = function () {
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  var $form = $('#new_user');
  $form.submit(function(event) {
    // Disable the submit button to prevent repeated clicks:
    $form.find('.submit').prop('disabled', true);

    // Request a token from Stripe:
    Stripe.card.createToken($form, stripeResponseHandler);

    // Prevent the form from being submitted:
    return false;
  });
  

}

var stripeResponseHandler = function (status, response) {
  var $form = $('#new_user');

	if (response.error) { // Problem!

    // Show the errors on the form:
    $('#main-container').prepend($('<div class="alert alert-warning">').text(response.error.message));
    $form.find('.submit').prop('disabled', false); // Re-enable submission

  } else { // Token was created!

    // Get the token ID:
    var token = response.id;

    // Insert the token ID into the form so it gets submitted to the server:
    $form.append($('<input type="hidden" name="user[stripe_card_token]">').val(token));

    // Submit the form:
    $form.get(0).submit();
  }
}

$(document).ready(main);