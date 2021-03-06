﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Google Maps Server-side Clustering</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link type="text/css" rel="stylesheet" href="/assets/styles/gmcKN.css?v=1" />
</head>

<!--
    Plain html example page
    -->

<body>
    <div id="gmcKN-errorMsg"></div>

    <div id="gmcKN-map-container">

        <div id="gmcKN-map"></div>

        <div id="gmcKN-checkboxContainer">

            <!-- These id values are used by the js for filtering data request -->
            <ul>
                <li><input type="checkbox" id="gmcKN-Type1" name="Type" value="Type1" checked="checked" /> <img src="/assets/images/markers/court.png" alt="court" /></li>
                <li><input type="checkbox" id="gmcKN-Type2" name="Type" value="Type2" checked="checked" /> <img src="/assets/images/markers/firstaid.png" alt="firstaid" /></li>
                <li><input type="checkbox" id="gmcKN-Type3" name="Type" value="Type3" checked="checked" /> <img src="/assets/images/markers/house.png" alt="house" /></li>
                <li><input type="checkbox" id="gmcKN-Lines" name="Type" value="Lines" /> <label>Lines</label> </li>
            </ul>
            <span id="gmcKN-Clustering-span">
                <input type="checkbox" id="gmcKN-Clustering" name="Type" value="Clustering" checked="checked" /> <label>Clustering</label>
            </span>
            <span id="gmcKN-zoomInfo"></span><br />
            <span id="gmcKN-markersCount"></span>
            <span id="gmcKN-cacheInfo"></span>
            <span id="gmcKN-response-time"></span>

        </div>
    </div>


    <script type="text/javascript" src="/assets/scripts/jquery.min.js"></script>   <!-- jQuery -->
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>   <!-- Google Maps -->
    <script type="text/javascript" src="/assets/scripts/gmcKN.js?v=1"></script>  <!-- Clustering -->

    <script>
        (function ($) {

            $('#gmcKN-Type1').click(function () { gmcKN.checkboxClicked('gmc_type1'); });
            $('#gmcKN-Type2').click(function () { gmcKN.checkboxClicked('gmc_type2'); });
            $('#gmcKN-Type3').click(function () { gmcKN.checkboxClicked('gmc_type3'); });
            $('#gmcKN-Lines').click(function () { gmcKN.checkboxClicked('gmc_meta_lines'); });
            $('#gmcKN-Clustering').click(function () { gmcKN.checkboxClicked('gmc_clustering'); });

        })(jQuery);
    </script>

    <script>
        // http://css-tricks.com/snippets/jquery/draggable-without-jquery-ui/
        (function ($) {
            $.fn.drags = function (opt) {
                opt = $.extend({ handle: "", cursor: "move" }, opt);
                var $el;

                if (opt.handle === "") $el = this;
                else $el = this.find(opt.handle);

                return $el.css('cursor', opt.cursor).on("mousedown", function (e) {
                    var $drag;
                    if (opt.handle === "") {
                        $drag = $(this).addClass('draggable');
                    } else {
                        $drag = $(this).addClass('active-handle').parent().addClass('draggable');
                    }

                    $drag.css('opacity', '0.50');

                    var z_idx = $drag.css('z-index'),
                        drg_h = $drag.outerHeight(),
                        drg_w = $drag.outerWidth(),
                        pos_y = $drag.offset().top + drg_h - e.pageY,
                        pos_x = $drag.offset().left + drg_w - e.pageX;
                    $drag.css('z-index', 1000).parents().on("mousemove", function (e) {
                        $('.draggable').offset({
                            top: e.pageY + pos_y - drg_h,
                            left: e.pageX + pos_x - drg_w
                        }).on("mouseup", function () {
                            $(this).removeClass('draggable').css('z-index', z_idx);
                        });
                    });
                    e.preventDefault(); // disable selection
                }).on("mouseup", function () {
                    if (opt.handle === "") {
                        $(this).removeClass('draggable');
                    } else {
                        $(this).removeClass('active-handle').parent().removeClass('draggable');
                    }

                    $(this).css('opacity', '0.85');
                });
            };

            $('#gmcKN-checkboxContainer').drags();
        })(jQuery);

    </script>

</body>

</html>

