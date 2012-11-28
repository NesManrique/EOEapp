$(document).ready(function() {

		var handlers = [1.5,2.5,3.5,4.5];
		
		function cnum(num){
			switch(num){
				case 0:
					return (handlers[0]-1)*25;
					break;
				case 1:
					return (handlers[1]-1)*25;
					break;
				case 2:
					return (handlers[2]-1)*25;
					break;
				case 3:
					return (handlers[3]-1)*25;
					break;
				default:
					return 0;
			}
		}
		
		function to100(num){
			return (num-1)*25;
		}

        $( "#weightage_slider" ).slider({ 
            min: 1,
            max: 5,
            step: 0.01,
            values: handlers, // set four handles
            slide: function( event, ui ) {
                // NOTE: during slide, the following sequence occurs: (i) change ui.value (ii) call this function (iii) move the slider handle

                // these four lines update the display of handle ranges
                $( "#weightage_style" ).val( "1" + " - " + $( "#weightage_slider" ).slider('values', 0) );
                $( "#weightage_design" ).val( $( "#weightage_slider" ).slider('values', 0) + " - " + $( "#weightage_slider" ).slider('values', 1) );
                $( "#weightage_correctness" ).val( $( "#weightage_slider" ).slider('values', 1) + " - " + $( "#weightage_slider" ).slider('values', 2) );
                $( "#weightage_others" ).val( $( "#weightage_slider" ).slider('values', 2) + " - " + $( "#weightage_slider" ).slider('values', 3) );
                $( "#weightage_oob" ).val( $( "#weightage_slider" ).slider('values', 3) + " - " + "5" );

                if ( ui.handle == $( "#weightage_slider_0" ).get(0) ) {
                    if(ui.values[ 0 ] >= ui.values[ 1 ]){
                        $( "#weightage_slider" ).slider('values', 0, ui.values[ 1 ]); // triggers change event
                        return false;
                    } else {
                        // handle-0 will move
                        // update display of colored handle ranges
                        $( "#weightage_slider_a" ).css('left', '0%');
                        $( "#weightage_slider_a" ).css('width', (to100(ui.values[0]) + '%'));
                        $( "#weightage_slider_b" ).css('left', (to100(ui.values[0]) + '%'));
                        $( "#weightage_slider_b" ).css('width', ((to100(ui.values[1])-to100(ui.values[0])) + '%'));
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
                        $( "#weightage_slider_b" ).css('left', (to100(ui.values[0]) + '%'));
                        $( "#weightage_slider_b" ).css('width', ((to100(ui.values[1]) - to100(ui.values[0])) + '%'));
                        $( "#weightage_slider_c" ).css('left', (to100(ui.values[1]) + '%'));
                        $( "#weightage_slider_c" ).css('width', ((to100(ui.values[2]) - to100(ui.values[1])) + '%'));
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
                        $( "#weightage_slider_c" ).css('left', (to100(ui.values[1]) + '%'));
                        $( "#weightage_slider_c" ).css('width', ((to100(ui.values[2]) - to100(ui.values[1])) + '%'));
                        $( "#weightage_slider_d" ).css('left', (to100(ui.values[2]) + '%'));
                        $( "#weightage_slider_d" ).css('width', ((to100(ui.values[3]) - to100(ui.values[2])) + '%'));
                    }
                }
                
                if ( ui.handle == $( "#weightage_slider_3" ).get(0) ) {
                    if(ui.values[ 3 ] <= ui.values[ 2 ]){
                        $( "#weightage_slider" ).slider('values', 3, ui.values[ 2 ]); // triggers change event
                        return false;
                    } else{
                        // handle-3 will move
                        // update display of colored handle ranges
                        $( "#weightage_slider_d" ).css('left', (to100(ui.values[2]) + '%'));
                        $( "#weightage_slider_d" ).css('width', ((to100(ui.values[3]) - to100(ui.values[2])) + '%'));
                        $( "#weightage_slider_e" ).css('left', (to100(ui.values[3]) + '%'));
                        $( "#weightage_slider_e" ).css('width', ((to100(5) - to100(ui.values[3])) + '%'));
                    }
                }
            }, 
            change: function( event, ui ) {
                // because slide event has function that changes handles' value programmatically, the following is necessary

                // these four lines update the display of handle ranges
                $( "#weightage_style" ).val( "1" + " - " + $( "#weightage_slider" ).slider('values', 0) );
                $( "#weightage_design" ).val( $( "#weightage_slider" ).slider('values', 0) + " - " + $( "#weightage_slider" ).slider('values', 1) );
                $( "#weightage_correctness" ).val( $( "#weightage_slider" ).slider('values', 1) + " - " + $( "#weightage_slider" ).slider('values', 2) );
                $( "#weightage_others" ).val( $( "#weightage_slider" ).slider('values', 2) + " - " + $( "#weightage_slider" ).slider('values', 3) );
                $( "#weightage_oob" ).val( $( "#weightage_slider" ).slider('values', 3) + " - " + "5" );

                // update display of colored handle ranges
                $( "#weightage_slider_a" ).css('left', '0%');
                $( "#weightage_slider_a" ).css('width', (to100(ui.values[0]) + '%'));
                $( "#weightage_slider_b" ).css('left', (to100(ui.values[0]) + '%'));
                $( "#weightage_slider_b" ).css('width', ((to100(ui.values[1]) - to100(ui.values[0])) + '%'));
                $( "#weightage_slider_c" ).css('left', (to100(ui.values[1]) + '%'));
                $( "#weightage_slider_c" ).css('width', ((to100(ui.values[2]) - to100(ui.values[1])) + '%'));
                $( "#weightage_slider_d" ).css('left', (to100(ui.values[2]) + '%'));
                $( "#weightage_slider_d" ).css('width', ((to100(ui.values[3]) - to100(ui.values[2])) + '%'));
                $( "#weightage_slider_e" ).css('left', (to100(ui.values[3]) + '%'));
                $( "#weightage_slider_e" ).css('width', ((to100(5) - to100(ui.values[3])) + '%'));
            }
        });

        // label each slider handle
        $( "#weightage_slider > a" ).each(function(index){
            $(this).attr('id', 'weightage_slider_' + index);
            $(this).attr('title', 'slider handle ' + index);    
        });

        // the following four div tags result in the display of colored handle ranges
        // the following left attributes and width attributes should be consistent with slider initialization - values array
        $('#weightage_slider').append("<div id='weightage_slider_a' class='ui-slider-range' style='left:0%;width:"+ cnum(0) + "%;background:#ffffff url(/assets/images/noalto.png) no-repeat center;'></div>");
        $('#weightage_slider').append("<div id='weightage_slider_b' class='ui-slider-range' style='left:"+ cnum(0) +"%;width:"+ (cnum(1)-cnum(0)) + "%;background:#ffcb96 url(/assets/images/casialto.png) no-repeat center;'></div>");
        $('#weightage_slider').append("<div id='weightage_slider_c' class='ui-slider-range' style='left:"+ cnum(1) +"%;width:"+ (cnum(2)-cnum(1)) + "%;background:#ff8000 url(/assets/images/alto.png) no-repeat center;'></div>");
        $('#weightage_slider').append("<div id='weightage_slider_d' class='ui-slider-range' style='left:"+ cnum(2) +"%;width:"+ (cnum(3)-cnum(2)) + "%;background:#ffcb96 url(/assets/images/casialto.png) no-repeat center;'></div>");
        $('#weightage_slider').append("<div id='weightage_slider_e' class='ui-slider-range' style='left:"+ cnum(3) +"%;width:"+ (100-cnum(3)) + "%;background:#ffffff url(/assets/images/noalto.png) no-repeat center;'></div>");

        // these four lines display the initial handle ranges
        $( "#weightage_style" ).val( "1" + " - " + $( "#weightage_slider" ).slider('values', 0) );
        $( "#weightage_design" ).val( $( "#weightage_slider" ).slider('values', 0) + " - " + $( "#weightage_slider" ).slider('values', 1) );
        $( "#weightage_correctness" ).val( $( "#weightage_slider" ).slider('values', 1) + " - " + $( "#weightage_slider" ).slider('values', 2) );
        $( "#weightage_others" ).val( $( "#weightage_slider" ).slider('values', 2) + " - " + $( "#weightage_slider" ).slider('values', 3) );
        $( "#weightage_oob" ).val( $( "#weightage_slider" ).slider('values', 3) + " - " + "5" );
        
          });
