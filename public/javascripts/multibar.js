$(document).ready(function() {

		$("#accordion").accordion({
			active: false,
			collapsible: true,
			heightStyle: "content"
		});

		var handlers = [1.5,2.5,3.5,4.5];
		var handlers1 = [1,2,3,4];
		var handlers2 = [1,1.5,3.9,4.2];
		
		function cnum(num,h){
			switch(num){
				case 0:
					return (h[0]-1)*25;
					break;
				case 1:
					return (h[1]-1)*25;
					break;
				case 2:
					return (h[2]-1)*25;
					break;
				case 3:
					return (h[3]-1)*25;
					break;
				default:
					return 0;
			}
		}
		
		function to100(num){
			return (num-1)*25;
		}

		//Slider maker index is for the container identifier, h is the values array and word is for the images in the slider
		function makeslider(index,h,word){
	        $("#weightage_slider_"+index).slider({ 
	            min: 1,
	            max: 5,
	            step: 0.01,
	            values: h, // set four handles
	            slide: function( event, ui ) {
	                
	                if(ui.handle == $("#weightage_slider_"+index+"_0").get(0)){
	                    if(ui.values[0] >= ui.values[1]){
	                        $("#weightage_slider_"+index).slider('values', 0, ui.values[1]); // triggers change event
	                        return false;
	                    } else {
	                        // handle-0 will move
	                        // update display of colored handle ranges
	                        $( "#weightage_slider_a_"+index ).css('left', '0%');
	                        $( "#weightage_slider_a_"+index ).css('width', (to100(ui.values[0]) + '%'));
	                        $( "#weightage_slider_b_"+index ).css('left', (to100(ui.values[0]) + '%'));
	                        $( "#weightage_slider_b_"+index ).css('width', ((to100(ui.values[1])-to100(ui.values[0])) + '%'));
	                    }
	                }
	
	                if (ui.handle == $("#weightage_slider_"+index+"_1" ).get(0)) {
	                    if(ui.values[1] <= ui.values[0]){
	                        $("#weightage_slider_"+index).slider('values', 1, ui.values[0]); // triggers change event
	                        return false;
	                    }else if(ui.values[ 1 ] >= ui.values[2]){
	                        $("#weightage_slider_"+index).slider('values', 1, ui.values[2]); // triggers change event
	                        return false;
	                    }else{
	                        // handle-1 will move
	                        // update display of colored handle ranges
	                        $( "#weightage_slider_b_"+index ).css('left', (to100(ui.values[0]) + '%'));
	                        $( "#weightage_slider_b_"+index ).css('width', ((to100(ui.values[1]) - to100(ui.values[0])) + '%'));
	                        $( "#weightage_slider_c_"+index ).css('left', (to100(ui.values[1]) + '%'));
	                        $( "#weightage_slider_c_"+index ).css('width', ((to100(ui.values[2]) - to100(ui.values[1])) + '%'));
	                    }
	                }
	
	                if(ui.handle == $("#weightage_slider_"+index+"_2").get(0)){
	                    if(ui.values[2] <= ui.values[1]){
	                        $("#weightage_slider_"+index).slider('values', 2, ui.values[1]); // triggers change event
	                        return false;
	                    }else if(ui.values[2] >= ui.values[3]){
	                    	$( "#weightage_slider_"+index ).slider('values', 2, ui.values[3]); // triggers change event
	                        return false;
	                    } else{
	                        // handle-2 will move
	                        // update display of colored handle ranges
	                        $("#weightage_slider_c_"+index).css('left', (to100(ui.values[1]) + '%'));
	                        $("#weightage_slider_c_"+index).css('width', ((to100(ui.values[2]) - to100(ui.values[1])) + '%'));
	                        $("#weightage_slider_d_"+index).css('left', (to100(ui.values[2]) + '%'));
	                        $("#weightage_slider_d_"+index).css('width', ((to100(ui.values[3]) - to100(ui.values[2])) + '%'));
	                    }
	                }
	                
	                if (ui.handle == $("#weightage_slider_"+index+"_3").get(0) ) {
	                    if(ui.values[3] <= ui.values[2]){
	                        $( "#weightage_slider_"+index ).slider('values', 3, ui.values[2]); // triggers change event
	                        return false;
	                    } else{
	                        // handle-3 will move
	                        // update display of colored handle ranges
	                        $("#weightage_slider_d_"+index).css('left', (to100(ui.values[2]) + '%'));
	                        $("#weightage_slider_d_"+index).css('width', ((to100(ui.values[3]) - to100(ui.values[2])) + '%'));
	                        $("#weightage_slider_e_"+index).css('left', (to100(ui.values[3]) + '%'));
	                        $("#weightage_slider_e_"+index).css('width', ((to100(5) - to100(ui.values[3])) + '%'));
	                    }
	                }
	                
	               	//change input values
					for (var i = 0; i < ui.values.length; ++i) {
	            		$("input.slide_val"+index+"[data-index=" + i + "]").val(ui.values[i]);
	        		}
	            },
	            
	            change: function(event, ui){
	               // because slide event has function that changes handles value programmatically, the following is necessary
					
	                // update display of colored handle ranges
	                $( "#weightage_slider_a_"+index ).css('left', '0%');
	                $( "#weightage_slider_a_"+index ).css('width', (to100(ui.values[0]) + '%'));
	                $( "#weightage_slider_b_"+index ).css('left', (to100(ui.values[0]) + '%'));
	                $( "#weightage_slider_b_"+index ).css('width', ((to100(ui.values[1]) - to100(ui.values[0])) + '%'));
	                $( "#weightage_slider_c_"+index ).css('left', (to100(ui.values[1]) + '%'));
	                $( "#weightage_slider_c_"+index ).css('width', ((to100(ui.values[2]) - to100(ui.values[1])) + '%'));
	                $( "#weightage_slider_d_"+index ).css('left', (to100(ui.values[2]) + '%'));
	                $( "#weightage_slider_d_"+index ).css('width', ((to100(ui.values[3]) - to100(ui.values[2])) + '%'));
	                $( "#weightage_slider_e_"+index ).css('left', (to100(ui.values[3]) + '%'));
	                $( "#weightage_slider_e_"+index ).css('width', ((to100(5) - to100(ui.values[3])) + '%'));
	            },
	            
	            create: function(event,ui){
	        		//setting input values	
		        	for (var i = 0; i < 4; ++i) {
		            	$("input.slide_val"+index+"[data-index=" + i + "]").val(h[i]);
		        	}
		        	
		        	//label each slider handle
		        	$( "#weightage_slider_"+index+" > a" ).each(function(ind){
		            	$(this).attr('id', 'weightage_slider_'+index+'_' + ind);
		        	});
		        	
		        	//the following four div tags result in the display of colored handle ranges
		        	//the following left attributes and width attributes should be consistent with slider initialization - values array
		        	$("#weightage_slider_"+index).append("<div id='weightage_slider_a_"+index+"' class='ui-slider-range' style='left:0%;width:"+ cnum(0,h) + "%;background:#ffffff url(/assets/images/no"+word+".png) no-repeat center;'></div>");
			        $("#weightage_slider_"+index).append("<div id='weightage_slider_b_"+index+"' class='ui-slider-range' style='left:"+ cnum(0,h) +"%;width:"+ (cnum(1,h)-cnum(0,h)) + "%;background:#ffcb96 url(/assets/images/casi"+word+".png) no-repeat center;'></div>");
			        $("#weightage_slider_"+index).append("<div id='weightage_slider_c_"+index+"' class='ui-slider-range' style='left:"+ cnum(1,h) +"%;width:"+ (cnum(2,h)-cnum(1,h)) + "%;background:#ff8000 url(/assets/images/"+word+".png) no-repeat center;'></div>");
			        $("#weightage_slider_"+index).append("<div id='weightage_slider_d_"+index+"' class='ui-slider-range' style='left:"+ cnum(2,h) +"%;width:"+ (cnum(3,h)-cnum(2,h)) + "%;background:#ffcb96 url(/assets/images/casi"+word+".png) no-repeat center;'></div>");
			        $("#weightage_slider_"+index).append("<div id='weightage_slider_e_"+index+"' class='ui-slider-range' style='left:"+ cnum(3,h) +"%;width:"+ (100-cnum(3,h)) + "%;background:#ffffff url(/assets/images/no"+word+".png) no-repeat center;'></div>");
			   
			    }
	        });
        }
		
		// Prevent submit when pressing enter and updating the written value
		$('.noEnterSubmit').keypress(function(e){
    		var $this = $(this);
    		var slidenum = $this.attr("class")[9];
    		var next = 0;
    		var prev = 0;
    		if(e.which == 13){

    			if(e.preventDefault){
    				e.preventDefault();
    				//console.log($this.attr("class")[9]+" "+$this.data("index")+" "+$this.val());
    				
		    		switch($this.data("index")){
		    			case 0:
		    				next = $("#weightage_slider_"+slidenum).slider("values", 1);
		    				if($this.val()>=next){
		    					return false;
		    				}else{
		    					$("#weightage_slider_"+slidenum).slider("values", $this.data("index"), $this.val());
		    				}
		    				break;
		    			case 1:
		    				prev = $("#weightage_slider_"+slidenum).slider("values", 0);
		    				next = $("#weightage_slider_"+slidenum).slider("values", 2);
		    				if($this.val()>=next){
		    					return false;
		    				}else if($this.val()<=prev){
		    					return false;
		    				}else{
		    					$("#weightage_slider_"+slidenum).slider("values", $this.data("index"), $this.val());
		    				}
		    				break;
		    			case 2:
		    				prev = $("#weightage_slider_"+slidenum).slider("values", 1);
			    			next = $("#weightage_slider_"+slidenum).slider("values", 3);
		    				if($this.val()>=next){
		    					return false;
		    				}else if($this.val()<=prev){
		    					return false;
		    				}else{
		    					$("#weightage_slider_"+slidenum).slider("values", $this.data("index"), $this.val());
		    				}
		    				break;
		    			case 3:
		    				prev = $("#weightage_slider_"+slidenum).slider("values", 2);
		    				if($this.val()<=prev){
		    					return false;
		    				}else{
		    					$("#weightage_slider_"+slidenum).slider("values", $this.data("index"), $this.val());
		    				}
		    				break;
		    			default:
		    				return false;
		    				break;
		    		}

                }else{
                	e.returnValue = false;
                }
    		}
    		
		});
		
		makeslider(0,handlers,"alto");
		makeslider(1,handlers1,"medio");
		makeslider(2,handlers2,"bajo");
        
});
