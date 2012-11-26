$(document).ready(function() {
        $( "#weightage_slider" ).slider({ 
            min: 0,
            max: 100,
            step: 1,
            values: [ 10, 20, 30, 75 ], // set four handles
            slide: function( event, ui ) {
                // NOTE: during slide, the following sequence occurs: (i) change ui.value (ii) call this function (iii) move the slider handle

                // these four lines update the display of handle ranges
                //$( "#weightage_style" ).val( "0" + " - " + $( "#weightage_slider" ).slider('values', 0) );
                //$( "#weightage_design" ).val( $( "#weightage_slider" ).slider('values', 0) + " - " + $( "#weightage_slider" ).slider('values', 1) );
                //$( "#weightage_correctness" ).val( $( "#weightage_slider" ).slider('values', 1) + " - " + $( "#weightage_slider" ).slider('values', 2) );
                //$( "#weightage_others" ).val( $( "#weightage_slider" ).slider('values', 2) + " - " + "100" );

                if ( ui.handle == $( "#weightage_slider_0" ).get(0) ) {
                    if(ui.values[ 0 ] >= ui.values[ 1 ]){
                        $( "#weightage_slider" ).slider('values', 0, ui.values[ 1 ]); // triggers change event
                        return false;
                    } else {
                        // handle-0 will move
                        // update display of colored handle ranges
                        $( "#weightage_slider_a" ).css('left', '0%');
                        $( "#weightage_slider_a" ).css('width', (ui.values[ 0 ] + '%'));
                        $( "#weightage_slider_b" ).css('left', (ui.values[ 0 ] + '%'));
                        $( "#weightage_slider_b" ).css('width', ((ui.values[1] - ui.values[0]) + '%'));
                    }
                }

                if ( ui.handle == $( "#weightage_slider_1" ).get(0) ) {
                    if(ui.values[ 1 ] <= ui.values[ 0 ]){
                        $( "#weightage_slider" ).slider('values', 1, ui.values[ 0 ]); // triggers change event
                        return false;
                    }else if(ui.values[ 1 ] >= ui.values[ 2 ]){
                        $( "#weightage_slider" ).slider('values', 1, ui.values[ 2 ]); // triggers change event
                        return false;
                    }else{
                        // handle-1 will move
                        // update display of colored handle ranges
                        $( "#weightage_slider_b" ).css('left', (ui.values[ 0 ] + '%'));
                        $( "#weightage_slider_b" ).css('width', ((ui.values[1] - ui.values[0]) + '%'));
                        $( "#weightage_slider_c" ).css('left', (ui.values[ 1 ] + '%'));
                        $( "#weightage_slider_c" ).css('width', ((ui.values[2] - ui.values[1]) + '%'));
                    }
                }

                if ( ui.handle == $( "#weightage_slider_2" ).get(0) ) {
                    if(ui.values[ 2 ] <= ui.values[ 1 ]){
                        $( "#weightage_slider" ).slider('values', 2, ui.values[ 1 ]); // triggers change event
                        return false;
                    }else if(ui.values[ 2 ] >= ui.values[ 3 ]){
                    	$( "#weightage_slider" ).slider('values', 2, ui.values[ 3 ]); // triggers change event
                        return false;
                    } else{
                        // handle-2 will move
                        // update display of colored handle ranges
                        $( "#weightage_slider_c" ).css('left', (ui.values[ 1 ] + '%'));
                        $( "#weightage_slider_c" ).css('width', ((ui.values[2] - ui.values[1]) + '%'));
                        $( "#weightage_slider_d" ).css('left', (ui.values[ 2 ] + '%'));
                        $( "#weightage_slider_d" ).css('width', ((ui.values[3] - ui.values[2]) + '%'));
                    }
                }
                
                if ( ui.handle == $( "#weightage_slider_3" ).get(0) ) {
                    if(ui.values[ 3 ] <= ui.values[ 2 ]){
                        $( "#weightage_slider" ).slider('values', 3, ui.values[ 2 ]); // triggers change event
                        return false;
                    } else{
                        // handle-3 will move
                        // update display of colored handle ranges
                        $( "#weightage_slider_d" ).css('left', (ui.values[ 2 ] + '%'));
                        $( "#weightage_slider_d" ).css('width', ((ui.values[3] - ui.values[2]) + '%'));
                        $( "#weightage_slider_e" ).css('left', (ui.values[ 3 ] + '%'));
                        $( "#weightage_slider_e" ).css('width', ((100 - ui.values[3]) + '%'));
                    }
                }
            }, 
            change: function( event, ui ) {
                // because slide event has function that changes handles' value programmatically, the following is necessary

                // these four lines update the display of handle ranges
                //$( "#weightage_style" ).val( "0" + " - " + $( "#weightage_slider" ).slider('values', 0) );
                //$( "#weightage_design" ).val( $( "#weightage_slider" ).slider('values', 0) + " - " + $( "#weightage_slider" ).slider('values', 1) );
                //$( "#weightage_correctness" ).val( $( "#weightage_slider" ).slider('values', 1) + " - " + $( "#weightage_slider" ).slider('values', 2) );
                //$( "#weightage_others" ).val( $( "#weightage_slider" ).slider('values', 2) + " - " + "100" );

                // update display of colored handle ranges
                $( "#weightage_slider_a" ).css('left', '0%');
                $( "#weightage_slider_a" ).css('width', (ui.values[ 0 ] + '%'));
                $( "#weightage_slider_b" ).css('left', (ui.values[ 0 ] + '%'));
                $( "#weightage_slider_b" ).css('width', ((ui.values[1] - ui.values[0]) + '%'));
                $( "#weightage_slider_c" ).css('left', (ui.values[ 1 ] + '%'));
                $( "#weightage_slider_c" ).css('width', ((ui.values[2] - ui.values[1]) + '%'));
                $( "#weightage_slider_d" ).css('left', (ui.values[ 2 ] + '%'));
                $( "#weightage_slider_d" ).css('width', ((ui.values[3] - ui.values[2]) + '%'));
                $( "#weightage_slider_e" ).css('left', (ui.values[ 3 ] + '%'));
                $( "#weightage_slider_e" ).css('width', ((100 - ui.values[3]) + '%'));
            }
        });

        // label each slider handle
        $( "#weightage_slider > a" ).each(function(index){
            $(this).attr('id', 'weightage_slider_' + index);
            $(this).attr('title', 'slider handle ' + index);    
        });

        // the following four div tags result in the display of colored handle ranges
        // the following left attributes and width attributes should be consistent with slider initialization - values array
        $('#weightage_slider').append("<div id='weightage_slider_a' class='ui-slider-range' style='left:0%;width:10%;background-color:#ffffff;'></div>");
        $('#weightage_slider').append("<div id='weightage_slider_b' class='ui-slider-range' style='left:10%;width:10%;background-color:#ffcb96;'></div>");
        $('#weightage_slider').append("<div id='weightage_slider_c' class='ui-slider-range' style='left:20%;width:10%;background-color:#ff8000;'></div>");
        $('#weightage_slider').append("<div id='weightage_slider_d' class='ui-slider-range' style='left:30%;width:45%;background-color:#ffcb96;'></div>");
        $('#weightage_slider').append("<div id='weightage_slider_e' class='ui-slider-range' style='left:75%;width:25%;background-color:#ffffff;'></div>");

        // these four lines display the initial handle ranges
        //$( "#weightage_style" ).val( "0" + " - " + $( "#weightage_slider" ).slider('values', 0) );
        //$( "#weightage_design" ).val( $( "#weightage_slider" ).slider('values', 0) + " - " + $( "#weightage_slider" ).slider('values', 1) );
        //$( "#weightage_correctness" ).val( $( "#weightage_slider" ).slider('values', 1) + " - " + $( "#weightage_slider" ).slider('values', 2) );
        //$( "#weightage_others" ).val( $( "#weightage_slider" ).slider('values', 2) + " - " + "100" );
        
          });
