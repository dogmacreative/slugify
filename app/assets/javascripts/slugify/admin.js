$(function() {
	$('[data-slug]')
		.each(function() {
			var $self = $(this);

			var name = $self.attr('name'),
				model = name.match(/([a-z_0-9]+)\[/)[1],
				targetProperty = $self.data('slug');

			var targetSelector = '[name="' + model + '[' + targetProperty + ']"]';

			$self
				.parents('form')
					.find(targetSelector)
						.on('change', function() {
							$self.val(URLify($(this).val()));
						});
		});
});