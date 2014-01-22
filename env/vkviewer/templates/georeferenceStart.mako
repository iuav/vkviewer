# -*- coding: utf-8 -*-
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"
      xmlns:tal="http://xml.zope.org/namespaces/tal"
      xmlns:i18n="http://xml.zope.org/namespaces/i18n"
      i18n:domain="vkviewer">
    <head>
        <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
        <title>Virtuelles Kartenforum 2.0</title>
        
        <!-- js/css -->
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/lib/jquery-ui-1.10.3/themes/base/jquery-ui.css')}" />
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/lib/fancyapps-fancyBox/source/jquery.fancybox.css')}" media="screen" />    
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/css/vk2/templates/styles.css')}" /> 
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/css/vk2/templates/basicFooterLayout.css')}" />       
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/css/vk2/templates/georeferenceStart.css')}" />
		<link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/css/vk2/tools/Georeferencer.css')}" />

		<!-- production --> 
      	<script src="${request.static_url('vkviewer:static/lib/min/OpenLayers.js')}"></script> 
	    <script src="${request.static_url('vkviewer:static/lib/min/vkviewer-libarys.min.js')}"></script> 
		<script src="${request.static_url('vkviewer:static/js/locale/'+_('js_library')+'.js')}"></script>	
	    <script src="${request.static_url('vkviewer:static/js/Vkviewer.min.js')}"></script>
	    
	    <!-- for testing --> 
	  	<!-- 	    
	  	<script src="${request.static_url('vkviewer:static/lib/min/jquery.min.js')}"></script>
	    <script src="${request.static_url('vkviewer:static/lib/min/jquery-ui-1.10.4.custom.js')}"></script>
	    <script src="${request.static_url('vkviewer:static/lib/min/jquery.fancybox.min.js')}"></script>
	    <script src="${request.static_url('vkviewer:static/lib/min/jquery.tabslideout.min.js')}"></script>  
	  	<script src="${request.static_url('vkviewer:static/lib/min/OpenLayers.js')}"></script> 
	  	<script src="${request.static_url('vkviewer:static/lib/closure-library/closure/goog/base.js')}"></script>
	  	<script src="${request.static_url('vkviewer:static/js/locale/'+_('js_library')+'.js')}"></script>	    
		<script src="${request.static_url('vkviewer:static/js/Vkviewer.js')}"></script> -->     	
      	


		<style>
			.olImageLoadError { 
	    /* when OL encounters a 404, don't display the pink image */
	    display: none !important;
	} 
		</style>
    </head>
	<body>	       
		
		<%block name="bodyBlock" />
		<div class="vk2GeoreferenceMtbStartPage">
			<div id="georeferenceMap" class="georeferenceMap"></div>			
		</div>
		
		<!-- Loading overlay screen -->
		<div id="georefLoadingScreen" class="georefLoadingScreen">
			<div class="centerLoading">
				<center><h2>Loading ... </h2></center>
				<img src="${request.static_url('vkviewer:static/images/ajax_loader.gif')}" />
			</div>
		</div>
		
		<!-- Link back to main page -->
		<a id="anchorBackToIndexPage" class="anchorBackToIndexPage" target="_top"
			 href="${request.route_url('home_login')}?georef=on"></a>
			 
		<!-- Footer --> 
        <div id="vk2Footer" class="vk2Footer">
        	<div class="footerContainer">
        		<div class="leftside">
        			<ul class="footerList">
        				<li class="listelement thick leftborder">${_('footer_project_name')}</li>
        				<li class="listelement">${_('footer_project_desc_long')}</li>
        			</ul>
        		</div>
        		<div class="rightside">
        		   	<ul class="footerList">
        		   	
        		   		% if faq_url:
         				<li class="listelement leftborder">
        					<a href="${faq_url}" class="vk2FooterLinks">FAQ</a>        				
        				</li>       		   		
        		   		% else:
        				<li class="listelement leftborder">
        					<a href="${request.route_url('faq')}" class="vk2FooterLinks">FAQ</a>        				
        				</li>
        				% endif
        				<li class="listelement leftborder">
         					<a href="${request.route_url('contact')}" class="vk2FooterLinks">${_('footer_contact')}</a>		
        				</li>        				
        				<li class="listelement leftborder">
        					<a href="${request.route_url('project')}" class="vk2FooterLinks">${_('footer_project')}</a>    				
        				</li>
        				<li class="listelement">
        					<a href="${request.route_url('impressum')}" class="vk2FooterLinks">${_('footer_editorial')}</a>
        				</li>
        			</ul>
        		</div>
        	</div>
        </div>
        
        <!-- sidebar -->
        <div id="vk2GeoreferenceToolsPanel" class="vk2GeoreferenceToolsPanel">
			<a id="vk2GeoreferenceToolsHandle" class="vk2GeoreferenceToolsHandle" 
				data-open="${request.static_url('vkviewer:static/images/layerbar.png')}" 
				data-close="${request.static_url('vkviewer:static/images/close.png')}"
				title="${_('tool_titel_georeference')}"></a>
		
			<!-- Georeference Tools Content -->

		</div>

		<script>
			var map = null;
			$(document).ready(function(){ 
				VK2.Utils.initializeFancyboxForClass('vk2FooterLinks');
		
				var urlParams = VK2.Utils.getAllUrlParams();
				map = VK2.Utils.Georef.initializeGeoreferencerMap('georeferenceMap', urlParams);
				var georeferenceTool = new VK2.Tools.Georeferencer({
					container: 'vk2GeoreferenceToolsPanel',
					handler: 'vk2GeoreferenceToolsHandle',
					map: map,
					controller: VK2.Controller.GeoreferenceController,
					urlParams: urlParams
				});
			});
		</script>
        
    </body>
</html>

