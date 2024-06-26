INSERT INTO `#__emails` (`headers`, `id`,`category_id`,`translation_parent_id`,`variant_parent_id`,`unsubscribeform_id`,`is_published`,`date_added`,`created_by`,`created_by_user`,`date_modified`,`modified_by`,`modified_by_user`,`checked_out`,`checked_out_by`,`checked_out_by_user`,`name`,`description`,`subject`,`from_address`,`from_name`,`reply_to_address`,`bcc_address`,`template`,`content`,`utm_tags`,`plain_text`,`custom_html`,`email_type`,`publish_up`,`publish_down`,`read_count`,`sent_count`,`revision`,`lang`,`variant_settings`,`variant_start_date`,`dynamic_content`,`variant_sent_count`,`variant_read_count`,`preference_center_id`)
VALUES
  ('[]',1,NULL,NULL,NULL,NULL,1,'2018-01-04 21:20:25',1,'Admin',NULL,NULL,NULL,NULL,NULL,NULL,'Campaign Test Email 1',NULL,'Campaign Test Email 1',NULL,NULL,NULL,NULL,'blank','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html><html xmlns=\"http://www.w3.org/1999/xhtml\" style=\"\" class=\" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths js csstransforms csstransforms3d csstransitions responsejs \"><head>\n        <title>{subject}</title>\n        <meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\" />\n        <style type=\"text/css\" media=\"only screen and (max-width: 480px)\">\n            /* Mobile styles */\n            @media only screen and (max-width: 480px) {\n                [class=\"w320\"] {\n                    width: 320px !important;\n                }\n                [class=\"mobile-block\"] {\n                    width: 100% !important;\n                    display: block !important;\n                }\n            }\n        </style>\n                                                                                                                   </head>\n    <body style=\"margin:0\" class=\"ui-sortable\">\n        <div data-section-wrapper=\"1\">\n            <center>\n                <table data-section=\"1\" style=\"width: 600;\" width=\"600\" cellpadding=\"0\" cellspacing=\"0\">\n                    <tbody>\n                        <tr>\n                            <td>\n                                <div data-slot-container=\"1\" style=\"min-height: 30px\" class=\"ui-sortable\">\n                                    <div data-slot=\"text\">\n                                        <br />\n                                        <h2>Hello there!</h2>\n                                        <br />\n                                        We haven\'t heard from you for a while...\n                                        <br />\n                                        <br />\n                                        {unsubscribe_text} | {webview_text}\n                                        <br />\n                                    </div>\n                                </div>\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </center>\n        </div>\n</body></html>','template',NULL,NULL,0,0,1,'en','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}',0,0,NULL),
  ('[]',2,NULL,NULL,NULL,NULL,1,'2018-01-04 21:21:07',1,'Admin',NULL,NULL,NULL,NULL,NULL,NULL,'Campaign Test Email 2',NULL,'Campaign Test Email 2',NULL,NULL,NULL,NULL,'blank','a:0:{}','a:4:{s:9:\"utmSource\";N;s:9:\"utmMedium\";N;s:11:\"utmCampaign\";N;s:10:\"utmContent\";N;}',NULL,'<!DOCTYPE html>\n<html>\n    <head>\n        <title>{subject}</title>\n        <meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\" />\n        <style type=\"text/css\" media=\"only screen and (max-width: 480px)\">\n            /* Mobile styles */\n            @media only screen and (max-width: 480px) {\n\n                [class=\"w320\"] {\n                    width: 320px !important;\n                }\n\n                [class=\"mobile-block\"] {\n                    width: 100% !important;\n                    display: block !important;\n                }\n            }\n        </style>\n    </head>\n    <body style=\"margin:0\">\n        <div data-section-wrapper=\"1\">\n            <center>\n                <table data-section=\"1\" style=\"width: 600;\" width=\"600\" cellpadding=\"0\" cellspacing=\"0\">\n                    <tbody>\n                        <tr>\n                            <td>\n                                <div data-slot-container=\"1\" style=\"min-height: 30px\">\n                                    <div data-slot=\"text\">\n                                        <br />\n                                        <h2>Hello there!</h2>\n                                        <br />\n                                        We haven\'t heard from you for a while...\n                                        <br />\n                                        <br />\n                                        {unsubscribe_text} | {webview_text}\n                                        <br />\n                                    </div>\n                                </div>\n                            </td>\n                        </tr>\n                    </tbody>\n                </table>\n            </center>\n        </div>\n    </body>\n</html>','template',NULL,NULL,0,0,1,'en','a:0:{}',NULL,'a:1:{i:0;a:3:{s:9:\"tokenName\";s:17:\"Dynamic Content 1\";s:7:\"content\";s:23:\"Default Dynamic Content\";s:7:\"filters\";a:1:{i:0;a:2:{s:7:\"content\";N;s:7:\"filters\";a:0:{}}}}}',0,0,NULL);

INSERT INTO `#__lead_tags` (`id`,`tag`)
VALUES
	(1,'CampaignTest'),
	(2,'US:NotOpen'),
	(3,'NonUS:NotOpen'),
	(4,'UK:NotOpen'),
	(5,'NonUK:NotOpen'),
	(6,'US:Action'),
	(7,'NonUS:Action'),
	(8,'Campaign Test'),
	(9,'EmailNotOpen'),
	(10,'ChainedAction');

INSERT INTO `#__campaigns` (`allow_restart`,`id`,`category_id`,`is_published`,`date_added`,`created_by`,`created_by_user`,`date_modified`,`modified_by`,`modified_by_user`,`checked_out`,`checked_out_by`,`checked_out_by_user`,`name`,`description`,`publish_up`,`publish_down`,`canvas_settings`)
VALUES
	(0, 1, NULL, 1, '2018-01-04 21:41:05', 1, 'Admin', '2018-03-08 23:27:28', 1, 'Admin User', NULL, NULL, 'Admin User', 'Campaign Test', NULL, NULL, NULL, 'a:2:{s:5:\"nodes\";a:16:{i:0;a:3:{s:2:\"id\";s:1:\"1\";s:9:\"positionX\";s:3:\"577\";s:9:\"positionY\";s:3:\"155\";}i:1;a:3:{s:2:\"id\";s:1:\"2\";s:9:\"positionX\";s:3:\"842\";s:9:\"positionY\";s:3:\"164\";}i:2;a:3:{s:2:\"id\";s:1:\"3\";s:9:\"positionX\";s:3:\"842\";s:9:\"positionY\";s:3:\"269\";}i:3;a:3:{s:2:\"id\";s:2:\"11\";s:9:\"positionX\";s:3:\"389\";s:9:\"positionY\";s:3:\"252\";}i:4;a:3:{s:2:\"id\";s:1:\"4\";s:9:\"positionX\";s:4:\"1132\";s:9:\"positionY\";s:3:\"373\";}i:5;a:3:{s:2:\"id\";s:1:\"5\";s:9:\"positionX\";s:3:\"841\";s:9:\"positionY\";s:3:\"378\";}i:6;a:3:{s:2:\"id\";s:2:\"10\";s:9:\"positionX\";s:3:\"597\";s:9:\"positionY\";s:3:\"378\";}i:7;a:3:{s:2:\"id\";s:2:\"12\";s:9:\"positionX\";s:3:\"168\";s:9:\"positionY\";s:3:\"334\";}i:8;a:3:{s:2:\"id\";s:2:\"13\";s:9:\"positionX\";s:3:\"391\";s:9:\"positionY\";s:3:\"335\";}i:9;a:3:{s:2:\"id\";s:2:\"14\";s:9:\"positionX\";s:4:\"1372\";s:9:\"positionY\";s:3:\"364\";}i:10;a:3:{s:2:\"id\";s:1:\"6\";s:9:\"positionX\";s:3:\"649\";s:9:\"positionY\";s:3:\"496\";}i:11;a:3:{s:2:\"id\";s:1:\"7\";s:9:\"positionX\";s:3:\"874\";s:9:\"positionY\";s:3:\"488\";}i:12;a:3:{s:2:\"id\";s:1:\"8\";s:9:\"positionX\";s:4:\"1097\";s:9:\"positionY\";s:3:\"486\";}i:13;a:3:{s:2:\"id\";s:1:\"9\";s:9:\"positionX\";s:4:\"1313\";s:9:\"positionY\";s:3:\"491\";}i:14;a:3:{s:2:\"id\";s:2:\"15\";s:9:\"positionX\";s:4:\"1563\";s:9:\"positionY\";s:3:\"291\";}i:15;a:3:{s:2:\"id\";s:5:\"lists\";s:9:\"positionX\";s:3:\"677\";s:9:\"positionY\";s:2:\"50\";}}s:11:\"connections\";a:15:{i:0;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:1:\"1\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:1;a:3:{s:8:\"sourceId\";s:5:\"lists\";s:8:\"targetId\";s:1:\"2\";s:7:\"anchors\";a:2:{s:6:\"source\";s:10:\"leadsource\";s:6:\"target\";s:3:\"top\";}}i:2;a:3:{s:8:\"sourceId\";s:1:\"2\";s:8:\"targetId\";s:1:\"3\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:3;a:3:{s:8:\"sourceId\";s:1:\"3\";s:8:\"targetId\";s:1:\"4\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:4;a:3:{s:8:\"sourceId\";s:1:\"3\";s:8:\"targetId\";s:1:\"5\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:5;a:3:{s:8:\"sourceId\";s:1:\"5\";s:8:\"targetId\";s:1:\"6\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:6;a:3:{s:8:\"sourceId\";s:1:\"5\";s:8:\"targetId\";s:1:\"7\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:7;a:3:{s:8:\"sourceId\";s:1:\"4\";s:8:\"targetId\";s:1:\"8\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:8;a:3:{s:8:\"sourceId\";s:1:\"4\";s:8:\"targetId\";s:1:\"9\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:9;a:3:{s:8:\"sourceId\";s:1:\"3\";s:8:\"targetId\";s:2:\"10\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:10;a:3:{s:8:\"sourceId\";s:1:\"1\";s:8:\"targetId\";s:2:\"11\";s:7:\"anchors\";a:2:{s:6:\"source\";s:6:\"bottom\";s:6:\"target\";s:3:\"top\";}}i:11;a:3:{s:8:\"sourceId\";s:2:\"11\";s:8:\"targetId\";s:2:\"12\";s:7:\"anchors\";a:2:{s:6:\"source\";s:3:\"yes\";s:6:\"target\";s:3:\"top\";}}i:12;a:3:{s:8:\"sourceId\";s:2:\"11\";s:8:\"targetId\";s:2:\"13\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:13;a:3:{s:8:\"sourceId\";s:1:\"3\";s:8:\"targetId\";s:2:\"14\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}i:14;a:3:{s:8:\"sourceId\";s:1:\"3\";s:8:\"targetId\";s:2:\"15\";s:7:\"anchors\";a:2:{s:6:\"source\";s:2:\"no\";s:6:\"target\";s:3:\"top\";}}}}');

INSERT INTO `#__campaign_events` (`id`,`campaign_id`,`parent_id`,`name`,`description`,`type`,`event_type`,`event_order`,`properties`,`trigger_date`,`trigger_interval`,`trigger_interval_unit`,`trigger_mode`,`decision_path`,`temp_id`,`channel`,`channel_id`,`failed_count`)
VALUES
	(1,1,NULL,'Tag CampaignTest',NULL,'lead.changetags','action',1,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"577\";s:8:\"droppedY\";s:3:\"155\";}s:4:\"name\";s:0:\"\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"1\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:4:{s:5:\"label\";s:21:\"Modify contact\'s tags\";s:11:\"description\";s:37:\"Add tag to or remove tag from contact\";s:8:\"formType\";s:16:\"modify_lead_tags\";s:9:\"eventName\";s:38:\"mautic.lead.on_campaign_trigger_action\";}s:6:\"tempId\";s:43:\"new86745ed0771cdfff79549cd84f17e9cc894e8903\";s:2:\"id\";s:43:\"new86745ed0771cdfff79549cd84f17e9cc894e8903\";s:8:\"add_tags\";a:1:{i:0;s:13:\"Campaign Test\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d','immediate',NULL,'new86745ed0771cdfff79549cd84f17e9cc894e8903',NULL,NULL,0),
	(2,1,NULL,'Send email 1',NULL,'email.send','action',1,'a:21:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"337\";s:8:\"droppedY\";s:3:\"155\";}s:4:\"name\";s:0:\"\";s:11:\"triggerMode\";s:4:\"date\";s:11:\"triggerDate\";O:8:\"DateTime\":3:{s:4:\"date\";s:26:\"2018-01-04 15:32:00.000000\";s:13:\"timezone_type\";i:3;s:8:\"timezone\";s:27:\"America/North_Dakota/Center\";}s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:10:\"leadsource\";s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"1\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"source\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:8:{s:5:\"label\";s:10:\"Send email\";s:11:\"description\";s:39:\"Send the selected email to the contact.\";s:9:\"eventName\";s:39:\"mautic.email.on_campaign_trigger_action\";s:8:\"formType\";s:14:\"emailsend_list\";s:15:\"formTypeOptions\";a:2:{s:13:\"update_select\";s:30:\"campaignevent_properties_email\";s:16:\"with_email_types\";b:1;}s:9:\"formTheme\";s:41:\"MauticEmailBundle:FormTheme\\EmailSendList\";s:7:\"channel\";s:5:\"email\";s:14:\"channelIdField\";s:5:\"email\";}s:6:\"tempId\";s:43:\"new8d8d68a07561544b6ae052e1344932e9dcff4f53\";s:2:\"id\";s:43:\"new8d8d68a07561544b6ae052e1344932e9dcff4f53\";s:5:\"email\";s:1:\"1\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}','{SEND_EMAIL_1_TIMESTAMP}',1,'d','date',NULL,'new8d8d68a07561544b6ae052e1344932e9dcff4f53','email',1,0),
	(3,1,2,'Opens email',NULL,'email.open','decision',2,'a:0:{}',NULL,0,NULL,NULL,NULL,'new7b70bc0bee1752ab041c85806f62e4480d582671',NULL,NULL,0),
	(4,1,3,'Is UK',NULL,'lead.field_value','condition',3,'a:17:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"942\";s:8:\"droppedY\";s:3:\"374\";}s:4:\"name\";s:5:\"Is UK\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:3:{s:5:\"field\";s:7:\"country\";s:8:\"operator\";s:1:\"=\";s:5:\"value\";s:14:\"United Kingdom\";}s:4:\"type\";s:16:\"lead.field_value\";s:9:\"eventType\";s:9:\"condition\";s:15:\"anchorEventType\";s:8:\"decision\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"field\";s:7:\"country\";s:8:\"operator\";s:1:\"=\";s:5:\"value\";s:14:\"United Kingdom\";}','{CONDITION_TIMESTAMP}',1,'d','date','no','new50630b403c8ee496674257bcd8eb739987cb681c',NULL,NULL,0),
	(5,1,3,'Is US',NULL,'lead.field_value','condition',3,'a:17:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"942\";s:8:\"droppedY\";s:3:\"374\";}s:4:\"name\";s:5:\"Is US\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:3:{s:5:\"field\";s:7:\"country\";s:8:\"operator\";s:1:\"=\";s:5:\"value\";s:13:\"United States\";}s:4:\"type\";s:16:\"lead.field_value\";s:9:\"eventType\";s:9:\"condition\";s:15:\"anchorEventType\";s:8:\"decision\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"field\";s:7:\"country\";s:8:\"operator\";s:1:\"=\";s:5:\"value\";s:13:\"United States\";}','{CONDITION_TIMESTAMP}',1,'d','date','no','new7e053fe42a72aadb09dd679698216c5a020fdc9c',NULL,NULL,0),
	(6,1,5,'Tag US:NotOpen',NULL,'lead.changetags','action',4,'a:16:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"741\";s:8:\"droppedY\";s:3:\"483\";}s:4:\"name\";s:14:\"Tag US:NotOpen\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"2\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:10:\"US:NotOpen\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d','immediate','yes','new258deb14812923521ffc071e80507c7c173c9bf2',NULL,NULL,0),
	(7,1,5,'Tag NonUS:NotOpen',NULL,'lead.changetags','action',4,'a:16:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"981\";s:8:\"droppedY\";s:3:\"483\";}s:4:\"name\";s:17:\"Tag NonUS:NotOpen\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"3\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:13:\"NonUS:NotOpen\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d','immediate','no','newa884023f692e4286283972779ee800d590a7c497',NULL,NULL,0),
	(8,1,4,'Tag UK:NotOpen',NULL,'lead.changetags','action',4,'a:16:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"501\";s:8:\"droppedY\";s:3:\"480\";}s:4:\"name\";s:14:\"Tag UK:NotOpen\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"4\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:10:\"UK:NotOpen\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d','immediate','yes','new2519374e41eb9686a786cc6cbf4ea8a91e7a3491',NULL,NULL,0),
	(9,1,4,'Tag NonUK:NotOpen',NULL,'lead.changetags','action',4,'a:16:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:4:\"1221\";s:8:\"droppedY\";s:3:\"480\";}s:4:\"name\";s:17:\"Tag NonUK:NotOpen\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"5\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:13:\"NonUK:NotOpen\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d','immediate','no','new41e0645e966bf4d3af3f768e3f57b95574ae1683',NULL,NULL,0),
	(10,1,3,'Send email 2',NULL,'email.send','action',3,'a:18:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"742\";s:8:\"droppedY\";s:3:\"374\";}s:4:\"name\";s:12:\"Send email 2\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:4:{s:5:\"email\";s:1:\"2\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";s:1:\"2\";s:8:\"attempts\";s:1:\"3\";}s:4:\"type\";s:10:\"email.send\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:8:\"decision\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"email\";s:1:\"2\";s:10:\"email_type\";s:13:\"transactional\";s:8:\"priority\";i:2;s:8:\"attempts\";d:3;}',NULL,1,'d','immediate','yes','new82c4acf5ed2d115566d7a0f27b3a844dc2732211','email',2,0),
	(11,1,1,'Is US',NULL,'lead.field_value','condition',2,'a:17:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"577\";s:8:\"droppedY\";s:3:\"260\";}s:4:\"name\";s:5:\"Is US\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:3:{s:5:\"field\";s:7:\"country\";s:8:\"operator\";s:1:\"=\";s:5:\"value\";s:13:\"United States\";}s:4:\"type\";s:16:\"lead.field_value\";s:9:\"eventType\";s:9:\"condition\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:5:\"field\";s:7:\"country\";s:8:\"operator\";s:1:\"=\";s:5:\"value\";s:13:\"United States\";}',NULL,1,'d','immediate',NULL,'new851108680198a4802062cf78f0d6db86407899a5',NULL,NULL,0),
	(12,1,11,'Tag US:Action',NULL,'lead.changetags','action',3,'a:16:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:2:\"12\";s:8:\"droppedY\";s:3:\"357\";}s:4:\"name\";s:13:\"Tag US:Action\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:3:\"yes\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"6\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:9:\"US:Action\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d','immediate','yes','new679bfa3e62cb59526de7fd27b556443485a174f0',NULL,NULL,0),
	(13,1,11,'Tag NonUS:Action',NULL,'lead.changetags','action',3,'a:16:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"489\";s:8:\"droppedY\";s:3:\"357\";}s:4:\"name\";s:16:\"Tag NonUS:Action\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"7\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:9:\"condition\";s:10:\"campaignId\";s:47:\"mautic_801d9c4d0208e42f6f2bae3f87d0899c3ac45b32\";s:6:\"_token\";s:43:\"uNCD4MZ1GsWRZue4ErJSTW5Tj1CX5R-NYgc5Q_BrVjw\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:12:\"NonUS:Action\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d','immediate','no','new62e190055219ebe5beb9df4c4a505bb0860fffd4',NULL,NULL,0),
	(14,1,3,'Tag EmailNotOpen',NULL,'lead.changetags','action',3,'a:19:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:4:\"1081\";s:8:\"droppedY\";s:3:\"374\";}s:4:\"name\";s:16:\"Tag EmailNotOpen\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"9\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:8:\"decision\";s:10:\"campaignId\";s:1:\"1\";s:6:\"_token\";s:43:\"oRiunE5unGEBGhTql8VkzvtTkMHpwElCu5Ul4-_gd-I\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"settings\";a:4:{s:5:\"label\";s:21:\"Modify contact\'s tags\";s:11:\"description\";s:37:\"Add tag to or remove tag from contact\";s:8:\"formType\";s:16:\"modify_lead_tags\";s:9:\"eventName\";s:38:\"mautic.lead.on_campaign_trigger_action\";}s:6:\"tempId\";s:43:\"newb3e5bfd9cdc154619ca0716b46f4a61328688a26\";s:2:\"id\";s:43:\"newb3e5bfd9cdc154619ca0716b46f4a61328688a26\";s:8:\"add_tags\";a:1:{i:0;s:12:\"EmailNotOpen\";}s:11:\"remove_tags\";a:0:{}}',NULL,2,'i','interval','no','newb3e5bfd9cdc154619ca0716b46f4a61328688a26',NULL,NULL,0),
	(15,1,3,'Tag EmailNotOpen Again',NULL,'lead.changetags','action',3,'a:16:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:4:\"1612\";s:8:\"droppedY\";s:3:\"374\";}s:4:\"name\";s:22:\"Tag EmailNotOpen Again\";s:11:\"triggerMode\";s:8:\"interval\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"6\";s:19:\"triggerIntervalUnit\";s:1:\"i\";s:6:\"anchor\";s:2:\"no\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:1:\"9\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:8:\"decision\";s:10:\"campaignId\";s:1:\"1\";s:6:\"_token\";s:43:\"Wd8bGtv2HJ6Nyf3K90Efoo2Rn2VkDWwXhwzCIPMiD-M\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:12:\"EmailNotOpen\";}s:11:\"remove_tags\";a:0:{}}',NULL,6,'i','interval','no','newf16dfec5f2a65aa9c527675e7be516020a90daa6',NULL,NULL,0),
	(16,1,12,'Tag ChainedAction',NULL,'lead.changetags','action',4,'a:16:{s:14:\"canvasSettings\";a:2:{s:8:\"droppedX\";s:3:\"168\";s:8:\"droppedY\";s:3:\"439\";}s:4:\"name\";s:14:\"Chained Action\";s:11:\"triggerMode\";s:9:\"immediate\";s:11:\"triggerDate\";N;s:15:\"triggerInterval\";s:1:\"1\";s:19:\"triggerIntervalUnit\";s:1:\"d\";s:6:\"anchor\";s:6:\"bottom\";s:10:\"properties\";a:1:{s:8:\"add_tags\";a:1:{i:0;s:2:\"10\";}}s:4:\"type\";s:15:\"lead.changetags\";s:9:\"eventType\";s:6:\"action\";s:15:\"anchorEventType\";s:6:\"action\";s:10:\"campaignId\";s:1:\"1\";s:6:\"_token\";s:43:\"6xgHe74aRnc1V7AGzdang3-iJ0Ub5BKfbdU5NsxQmv0\";s:7:\"buttons\";a:1:{s:4:\"save\";s:0:\"\";}s:8:\"add_tags\";a:1:{i:0;s:13:\"ChainedAction\";}s:11:\"remove_tags\";a:0:{}}',NULL,1,'d','immediate',NULL,'new60f74507aeccf217f78647e41ae29af51debe666',NULL,NULL,0);

INSERT INTO `#__lead_lists` (`id`,`is_preference_center`, `is_published`,`date_added`,`created_by`,`created_by_user`,`date_modified`,`modified_by`,`modified_by_user`,`checked_out`,`checked_out_by`,`checked_out_by_user`,`name`,`description`,`alias`,`filters`,`is_global`, `public_name`)
VALUES
  (1,0,1,'2018-01-04 23:41:20',1,'Admin User',NULL,NULL,NULL,NULL,NULL,NULL,'Campaign Test',NULL,'campaign-test','a:0:{}',1,'campaign-test');

INSERT INTO `#__campaign_leadlist_xref` (`campaign_id`,`leadlist_id`)
VALUES
	(1,1);

INSERT INTO `#__campaign_leads` (`campaign_id`,`lead_id`,`date_added`,`manually_removed`,`manually_added`,`date_last_exited`,`rotation`)
VALUES
	(1,1,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,2,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,3,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,4,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,5,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,6,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,7,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,8,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,9,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,10,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,11,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,12,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,13,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,14,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,15,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,16,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,17,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,18,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,19,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,20,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,21,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,22,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,23,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,24,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,25,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,26,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,27,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,28,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,29,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,30,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,31,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,32,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,33,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,34,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,35,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,36,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,37,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,38,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,39,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,40,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,41,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,42,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,43,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,44,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,45,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,46,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,47,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,48,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,49,'2018-01-04 22:47:30',0,1,NULL,1),
	(1,50,'2018-01-04 22:47:30',0,1,NULL,1);

INSERT INTO `#__lead_lists_leads` (`leadlist_id`,`lead_id`,`date_added`,`manually_removed`,`manually_added`)
VALUES
    (1,1,'2018-01-04 22:47:00',0,1),
    (1,2,'2018-01-04 22:47:00',0,1),
    (1,3,'2018-01-04 22:47:00',0,1),
    (1,4,'2018-01-04 22:47:00',0,1),
    (1,5,'2018-01-04 22:47:00',0,1),
    (1,6,'2018-01-04 22:47:00',0,1),
    (1,7,'2018-01-04 22:47:00',0,1),
    (1,8,'2018-01-04 22:47:00',0,1),
    (1,9,'2018-01-04 22:47:00',0,1),
    (1,10,'2018-01-04 22:47:00',0,1),
    (1,11,'2018-01-04 22:47:00',0,1),
    (1,12,'2018-01-04 22:47:00',0,1),
    (1,13,'2018-01-04 22:47:00',0,1),
    (1,14,'2018-01-04 22:47:00',0,1),
    (1,15,'2018-01-04 22:47:00',0,1),
    (1,16,'2018-01-04 22:47:00',0,1),
    (1,17,'2018-01-04 22:47:00',0,1),
    (1,18,'2018-01-04 22:47:00',0,1),
    (1,19,'2018-01-04 22:47:00',0,1),
    (1,20,'2018-01-04 22:47:00',0,1),
    (1,21,'2018-01-04 22:47:00',0,1),
    (1,22,'2018-01-04 22:47:00',0,1),
    (1,23,'2018-01-04 22:47:00',0,1),
    (1,24,'2018-01-04 22:47:00',0,1),
    (1,25,'2018-01-04 22:47:00',0,1),
    (1,26,'2018-01-04 22:47:00',0,1),
    (1,27,'2018-01-04 22:47:00',0,1),
    (1,28,'2018-01-04 22:47:00',0,1),
    (1,29,'2018-01-04 22:47:00',0,1),
    (1,30,'2018-01-04 22:47:00',0,1),
    (1,31,'2018-01-04 22:47:00',0,1),
    (1,32,'2018-01-04 22:47:00',0,1),
    (1,33,'2018-01-04 22:47:00',0,1),
    (1,34,'2018-01-04 22:47:00',0,1),
    (1,35,'2018-01-04 22:47:00',0,1),
    (1,36,'2018-01-04 22:47:00',0,1),
    (1,37,'2018-01-04 22:47:00',0,1),
    (1,38,'2018-01-04 22:47:00',0,1),
    (1,39,'2018-01-04 22:47:00',0,1),
    (1,40,'2018-01-04 22:47:00',0,1),
    (1,41,'2018-01-04 22:47:00',0,1),
    (1,42,'2018-01-04 22:47:00',0,1),
    (1,43,'2018-01-04 22:47:00',0,1),
    (1,44,'2018-01-04 22:47:00',0,1),
    (1,45,'2018-01-04 22:47:00',0,1),
    (1,46,'2018-01-04 22:47:00',0,1),
    (1,47,'2018-01-04 22:47:00',0,1),
    (1,48,'2018-01-04 22:47:00',0,1),
    (1,49,'2018-01-04 22:47:00',0,1),
    (1,50,'2018-01-04 22:47:00',0,1);
