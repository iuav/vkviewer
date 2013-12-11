# -*- coding: utf-8 -*-
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"
      xmlns:tal="http://xml.zope.org/namespaces/tal"
      xmlns:i18n="http://xml.zope.org/namespaces/i18n"
      i18n:domain="vkviewer">
    <head>
        <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
        <title>Virtuelles Kartenforum 2.0</title>
        
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/lib/jquery-ui-1.10.3/themes/base/jquery-ui.css')}" />
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/css/vk2/templates/styles.css')}" /
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/css/vk2/templates/faq.css')}" />
        <link rel="stylesheet" type="text/css" href="${request.static_url('vkviewer:static/css/vk2/templates/faqLoggedIn.css')}" />               
      	<script src="${request.static_url('vkviewer:static/lib/jquery.js')}"></script>
      	<script src="${request.static_url('vkviewer:static/lib/jquery-ui.js')}"></script>
    </head>
    
    <script>
   	
    </script>  
	<body>
	    <div class="vk2FaqContainer">
			<div class="vk2FaqHeaderContainer">
	    		<h2 class="slubcolor">${_('faq_main_heading')}</h2>
	    	</div>
	    	<br>
	    	<div class="vk2FaqBodyContainer">
	    		<h4 class="slubcolor">${_('faq_main_georef_heading')}</h4>
	    		<div class="vk2FaqMainGeorefContainer">
					<ol>
						<li>${_('faq_main_georef_1')}</li><br>
						<li>${_('faq_main_georef_2')}</li><br>
						<li>${_('faq_main_georef_3_1')} <br><br>
							<u>${_('faq_main_georef_hint')}</u>: ${_('faq_main_georef_3_2')}<br><br>
							<u>${_('faq_main_georef_hint')}</u>: ${_('faq_main_georef_3_3')}
						</li><br>
					</ol>	    			
	    		</div>
	    	</div>
	    </div>
    </body>
</html>
