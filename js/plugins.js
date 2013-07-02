// Avoid `console` errors in browsers that lack a console.
(function() {
    var method;
    var noop = function () {};
    var methods = [
        'assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error',
        'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log',
        'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd',
        'timeStamp', 'trace', 'warn'
    ];
    var length = methods.length;
    var console = (window.console = window.console || {});

    while (length--) {
        method = methods[length];

        // Only stub undefined methods.
        if (!console[method]) {
            console[method] = noop;
        }
    }
}());

// Place any jQuery/helper plugins in here.

// Toggle menu
(function() {
    $('.nav .dropdown-toggle').click(function (e) {
        $('.nav .dropdown-toggle').parent().toggleClass('open');
        e.stopPropagation();
    });

    $('.nav .dropdown-menu a').click(function (e) {
        $(this).toggleClass('selected');
        e.stopPropagation();
    });

    $(document).click(function () {
        $('.nav .dropdown-toggle').parent().removeClass('open');
    });
}());

// Toggle modal
(function() {
    $('.brand').click(function () {
        $('#lightbox').modal('show');
    });

}());