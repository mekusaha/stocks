<!DOCTYPE html>
<html>
<head>
	<title>Mekon InfoCorp Stock</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		function executeQuery(value) {			
		  	$.ajax({
			    url: 'https://www.bqprime.com/next/feapi/stock/'+value+'/basic-details',
			    dataType: 'json',
			    success: function(result) {
			    	
			    	if (result.updated){
				      	var bseprevClose = result.data.bse["previousClose"];
				      	var bsecurrentPrice = result.data.bse["currentPrice"];
				      	var bseopenPrice = result.data.bse["openPrice"];
				      	var bsedayHigh = result.data.bse["dayHigh"];
				      	var bsedayLow = result.data.bse["dayLow"];
				      	var bsepriceChange = result.data.bse["priceChange"];
				      	var bsepricePercentageChange = result.data.bse["changePercentage"];


				      	var nseprevClose = result.data.nse["previousClose"];
				      	var nsecurrentPrice = result.data.nse["currentPrice"];
				      	var nseopenPrice = result.data.nse["openPrice"];
				      	var nsedayHigh = result.data.nse["dayHigh"];
				      	var nsedayLow = result.data.nse["dayLow"];
				      	var nsepriceChange = result.data.nse["priceChange"];
				      	var nsepricePercentageChange = result.data.nse["changePercentage"];

				      	var lastUpdated = new Date(result.updated).toLocaleDateString("en-US")
				      	//var lastUpdated = result.updated;

			    		
				      	$("#card-header").html($("#compname_"+value).val());
				      	
				      	//BSE
				      	$("#bsepriceChange").html("BSE Price Change : Rs."+bsepriceChange);
				      	$("#bsepricePercentageChange").html("BSE Price Change Percentage : "+bsepricePercentageChange+"%");
				      	$("#blastUpdated").html("BSE Previous Close : "+bseprevClose+"<br>BSE Open Price : "+bseopenPrice+"<br>BSE Day High : "+bsedayHigh+"<br>BSE Day Low : "+bsedayLow+"<br>Data last updated on "+lastUpdated);
				      	$("#bcurrentPrice").html(" BSE Current Price : "+bsecurrentPrice);

				      	//NSE
				      	$("#nsepriceChange").html("NSE Price Change : Rs."+bsepriceChange);
				      	$("#nsepricePercentageChange").html("BSE Price Change Percentage : "+bsepricePercentageChange+"%");
				      	$("#nlastUpdated").html("NSE Previous Close : "+nseprevClose+"<br>NSE Open Price : "+nseopenPrice+"<br>NSE Day High : "+nsedayHigh+"<br>NSE Day Low : "+nsedayLow+"<br>Data last updated on "+lastUpdated);
				      	$("#ncurrentPrice").html(" NSE Current Price : "+nsecurrentPrice);



				      	$(".card").show();
		      			$(".main").show();


		      			$(".spinBtn").hide();
					  	$("#spinner").hide();
					  	$("#spinner-border-message").text("");
		      			//$("#spinner").hide();
				  		//$("#spinner-border-message span").text("Search Finished");
				  	} 
				  	
			    }
		    
		  	});
		  	// STOCK-Details
		  	//https://www.bqprime.com/next/feapi/stock/779228/stock-dna
		  	$.ajax({
			    url: 'https://www.bqprime.com/next/feapi/stock/'+value+'/stock-dna',
			    dataType: 'json',
			    success: function(result) {
			    	if (result.updated){
				      	var exchange = result.data["exchange"];
				      	var stock = result.data["stock"];
				      	var sensex = result.data["sensex"];
				      	var market500 = result.data["market500"];
				      	var industry = result.data["industry"];
				      	var marketCap = result.data["marketCap"];
				      	var peRatio = result.data["peRatio"];
				      	var dividendYield = result.data["dividendYield"];
			    		
				      	$("#dividendYield").html("Dividend Yield : "+dividendYield+"<small>["+marketCap+"]</small>");
				      	$("#industry").html(industry);
				  	} 
			    }
		  	});

		  	$.ajax({
			    url: 'https://www.bqprime.com/next/feapi/stock/'+value+'/movement?duration=1D',
			    dataType: 'json',
			    success: function(result) {
			    	if (result){
			    		var xArr = [];
			    		var yArr = [];
			    		var graphData = result.data.graphDetails.graph;
				    	//console.log(graphData);
				      	$.each(graphData, function(key, value){
				      		xArr.push(value[0]);
				      		yArr.push(value[1]);
				      	});
				      	

				      	const labels = xArr;

				      	const data = {
						    labels: labels,
						    datasets: [{
						      label: 'Past 10 Years Chart',
						      backgroundColor: 'rgb(255, 99, 132)',
						      borderColor: 'rgb(255, 99, 132)',
						      data: yArr,
						    }]
						};


				      	const config = {
						  type: 'bar',
						  data: data,
						  options: {
						    scales: {
						      y: {
						        beginAtZero: true
						      }
						    }
						  },
						};

						const myChart = new Chart(
						    document.getElementById('myChart'),
						    config
						);
							
						
					//https://www.bqprime.com/next/feapi/stock/"+value+"/movement?duration=10Y
					//https://canvasjs.com/data/gallery/jquery/samsung-electronics-stock-price.json
					/*$.get("https://www.bqprime.com/next/feapi/stock/"+value+"/movement?duration=10Y",function(dps) {
						console.log(dps);
						options.data[0].dataPoints = dps;
						//alert(options.data[0].dataPoints);
						$("#chartContainer").CanvasJSChart().render();
					});*/
				}
			    }
		  	});
		}

		$(document).ready(function() {
			$(".spinBtn").hide();
			$(".card").hide();
			//setTimeout(executeQuery("HHM"), 5000);
		});
	</script>
	<script>
		$(document).ready(function() {
		  $('#searchStock').keyup(function() {
		  	
		  	var searchItem = $('#searchStock').val();

		  	if(searchItem.length > 3){
			  	$(".spinBtn").show();
			  	$("#spinner").show();
			  	$("#spinner-border-message").text("Searching");

			  	$('#searchResultList').html('');

			  	var searchField = $('#searchStock').val();
			  	var expression = new RegExp(searchField, "i");
			  	$.getJSON('https://www.bqprime.com/frontend-api/stocks?limit=10000', function(data){
			  		$.each(data, function(key, value){
			  			
			  				//if (value.COMPNAME.search(expression) != -1 || value.nsecode.search(expression) != -1){
			  				if (value.COMPNAME.search(expression) != -1 ){
			  					//$('#searchResultList').append('<li>'+value.COMPNAME+'</li>');
			  					//list-group-item
			  					//counter++;
				  				$('#searchResultList').append("<li id="+value.STOCKID+" class='dropdown-item'><div id="+value.STOCKID+" class='d-flex w-100 justify-content-between'>"+value.COMPNAME+"</div><p id="+value.STOCKID+" class='mb-1'>"+value.bsecode+"<small id="+value.STOCKID+" class='text-muted'> ["+value.STOCKID+"]</small></p><input id='compname_"+value.STOCKID+"' style='display:none' value='"+value.COMPNAME+"'></input></li>");
			  					//executeQuery(value.STOCKID);
			  					$('#searchResultList').show();
			  					$("#spinner").hide();
					  			//$("#spinner-border-message").text("Search Finished");
					  			$(".spinBtn").hide();

				  			}
			  			//}
			  		});
			  	})
			  }
		  });


		  /*$('#searchStockBtn').click(function() {
		  	$("#homeNotification1").hide();
		  	$(".spinBtn").show();
		  	var searchStockValue = $('#searchStock').val();
		  	//alert(searchStockValue);
		  	executeQuery(searchStockValue);
		  });*/
		});
	</script>
</head>
<body style="font-weight: 5px">

	<div style="padding: 50px 30px">
		<!--div class="spinner-border text-primary" role="status" style="display:block">
		  <span class="visually-hidden">Loading...</span>
		</div-->

		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		  <div class="container-fluid">
		    <span class="navbar-brand">Mekon</span>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    <div class="collapse navbar-collapse" id="navbarSupportedContent">
		      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
		        <li class="nav-item">
		          <a class="nav-link active" aria-current="page" href="#">Home</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="#">Link</a>
		        </li>
		        <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            Dropdown
		          </a>
		          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
		            <li><a class="dropdown-item" href="#">Action</a></li>
		            <li><a class="dropdown-item" href="#">Another action</a></li>
		            <li><hr class="dropdown-divider"></li>
		            <li><a class="dropdown-item" href="#">Something else here</a></li>
		          </ul>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		        </li>
		      </ul>
		      <div class="d-flex">
		      	<button class="btn btn-warning spinBtn" type="button" style="font-size: 13px; margin-right: 10px; float:left; display:flex;" disabled>
				  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" id="spinner" style="font-size: 13px;margin-top: 3px;margin-right: 3px;"></span>
				  <span>&nbsp;</span> 
				  <span id="spinner-border-message"> Loading... </span>
				</button>
		        <input class="form-control me-2 d-inline-block" type="search" placeholder="Search" aria-label="Search" id="searchStock" tabindex="0" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-content="Disabled popover">
		        <button class="btn btn-outline-success" id="searchStockBtn" style="display: none">Search</button>
		      </div>
		    </div>
		  </div>
		</nav>
		<div class="row g-0">
		  <div class="col-sm-6 col-md-8"> </div>
		  <div class="col-6 col-md-4"><ul class="list-group overflow-auto dropdown-menu" style="max-height: 100px; margin-bottom: 10px; overflow:scroll; -webkit-overflow-scrolling: touch; display:none; border: transparent;" id="searchResultList"></ul></div>
		</div>
		
		<div id="homeNotification1" style="padding: 20px 40px;"><h2>  Stocks Dashboard </h2></div>

		
		<div class="container">
		  <div class="row">
		    <div class="col">
		      	<div class="card">
				  	<h5 class="card-header" id="card-header"></h5>
				  
			      	<div class="row">
					    <div class="col">
						  <div class="card-body">
						    <h5 class="card-title" id="bsepriceChange"></h5>
						    <p class="card-text" id="bsepricePercentageChange"></p>
						    <p class="card-text" id="blastUpdated"></p>
						    <a href="#" class="btn btn-info" id="bcurrentPrice"></a>
						  </div>
						</div>
						<div class="col">
						  <div class="card-body">
						    <h5 class="card-title" id="nsepriceChange"></h5>
						    <p class="card-text" id="nsepricePercentageChange"></p>
						    <p class="card-text" id="nlastUpdated"></p>
						    <a href="#" class="btn btn-info" id="ncurrentPrice"></a>
						  </div>
						</div>
					</div>
				</div>
		    </div>
		    <div class="col">
		      <div class="card">
				  <h5 class="card-header" id="dividendYield"></h5>
				  <div class="card-body">
				    <h5 class="card-title" id="industry"></h5>
				    <canvas id="myChart" style="width:100%;"></canvas>
				    <!--p class="card-text" id="bsepricePercentageChange"></p>
				    <p class="card-text" id="lastUpdated"></p>
				    <a href="#" class="btn btn-info" id="currentPrice"></a-->
				  </div>
				</div>
		    </div>
		  </div>
		  <div class="row">
		  	<div class="col-lg-12">
		      
		    </div>
		  </div>
		</div>


		  <!--a href="#" class="list-group-item">
		    <div class="d-flex w-100 justify-content-between">
		      <h5 class="mb-1">List group item heading</h5>
		      <small class="text-muted">3 days ago</small>
		    </div>
		    <p class="mb-1">Some placeholder content in a paragraph.</p>
		    <small class="text-muted">And some muted small print.</small>
		  </a-->
		

		<br />
		

		<ul id="result"></ul>

	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>	
	<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
	<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
	<script>
		function plotChart(a,b,value){
			//alert(x);
			//alert(y);
			var options = {
				animationEnabled: true,
				theme: "light2", // "light1", "light2", "dark1", "dark2"
				exportEnabled: true,
				title: {
					text: "Samsung Electronics Co. Ltd. - November 2017"
				},
				subtitles: [{
					text: "Weekly Averages"
				}],
				axisX: {
					valueFormatString: "DD MMM"
				},
				axisY: {
					prefix: "₩",
					title: "Price",
					valueFormatString: "#0.0,,.M"
				}, 
				legend: {
					dockInsidePlotArea: true
				},
				data: [{
					type: "candlestick",
					showInLegend: true,
					legendText: "Currency in KRW - South Korean Won",
					xValueType: "dateTime",
					yValueFormatString: "₩#,#00.##",
					xValueFormatString: "DD MMM",
					risingColor: "#CBE8C8",
					fallingColor: "#FFCCCC",
					dataPoints: []
				}]
			};

			$("#chartContainer").CanvasJSChart(options);
			//https://www.bqprime.com/next/feapi/stock/"+value+"/movement?duration=10Y
			//https://canvasjs.com/data/gallery/jquery/samsung-electronics-stock-price.json
			$.get("https://www.bqprime.com/next/feapi/stock/"+value+"/movement?duration=10Y",function(dps) {
				console.log(dps);
				options.data[0].dataPoints = dps;
				//alert(options.data[0].dataPoints);
				$("#chartContainer").CanvasJSChart().render();
			});
		}
	</script>
	<script type="text/javascript">
	    // locate your element and add the Click Event Listener
	    var el = document.getElementById("searchResultList");
	    if(el){
		    el.addEventListener("click",function(e) {
		    	$('#searchResultList').hide();
		    	$(".spinBtn").show();
			  	$("#spinner").show();
			  	$("#spinner-border-message").text("Loading");
		    	//console.log(e.target.nodeName);
		        // e.target is our targetted element.
		                    // try doing console.log(e.target.nodeName), it will result LI
		        if(e.target && (e.target.nodeName == "LI" || e.target.nodeName == "DIV" || e.target.nodeName=="SMALL" || e.target.nodeName=="P")) {
		            //console.log(e.target.id + " was clicked");
		            //alert(e.target.id);
		            executeQuery(e.target.id); 
		        }
		    });
		}
	</script>
</body>
</html>