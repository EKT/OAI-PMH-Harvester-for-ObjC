OAI-PMH-Harvester-for-ObjC
==========================


Introduction
------------
OAI-PMH Objective-C harvester is an Objective C library/wrapper over the <a target="_blank" href="http://www.openarchives.org/OAI/openarchivesprotocol.html">OAI-PMH protocol</a>. 
The Open Archives Initiative Protocol for Metadata Harvesting (OAI-PMH) is a low-barrier mechanism for repository interoperability. Data Providers are repositories that expose structured metadata via OAI-PMH. Service Providers or metadata harvesters (like this one) then make OAI-PMH service requests to harvest that metadata. OAI-PMH is a set of six verbs or services that are invoked within HTTP.

Installation
------------
1) Download or clone this project on your machine<br/>
2) Copy & Paste the folder <b>OAIHarvester</b> in your project, drag the folder in your Xcode project as usual<br/>
3) In your projects precompiled header file (.pch extension) add the following lines<br/>

	#import "TouchXML.h"
    #define BASE_NAMESPACE @"http://www.openarchives.org/OAI/2.0/"

4) Enable <b>libxml2</b> library<br/>
* In Xcode, within <b>Build Settings</b>, search for <b>Header search paths</b> setting and add `/usr/include/libxml2` value to it
* In the same place, search for <b>Other linker flags</b> setting and add `-lxml2` value

5) You are ready to use the library

Usage
-----------
Instantiate a new harvester<br/>
`OAIHarvester *harvester = [[OAIHarvester alloc] initWithBaseURL:@"PLACE THE OAI BASE URL OF YOUR REPOSITORY HERE"];`<br/>
<br/>Identify instance is ready for you:<br\>

  	NSLog(@"repo name = %@", harvester.identify.repositoryName);
  	NSLog(@"baseURL = %@", harvester.identify.baseURL);
	NSLog(@"granularity = %@", harvester.identify.granularity);
	for (NSString *email in harvester.identify.adminEmails){
		NSLog(@"admin email = %@", email);
	}
	for (NSString *compression in harvester.identify.compressions){
		NSLog(@"compression = %@", compression);
	}

<br/>Metadata formats are also ready for you:

	for (MetadataFormat *format in harvester.metadataFormats){
        NSLog(@"%@: %@", format.prefix, format.namespce);
    }

<br/>Sets are also ready for you:

	for (Set *set in harvester.sets){
        NSLog(@"%@: %@", set.fullSpec, set.name);
    }

<br/>Define metadata prefix and set for your harvester (the latter is optional):

	harvester.metadataPrefix = @"oai_dc";
	harvester.setSpec = ((Set *)[harvester.sets objectAtIndex:0]).fullSpec;

<br/>List records (1st way - using resumption tokens):

	NSArray *records = [harvester listRecordsWithResumptionToken:nil error:&error];
	if (error){
        NSLog(@"error = %@", [error localizedDescription]);
    }
    else {
        if ([harvester hasNextRecords]){
            NSArray *records2 = [harvester getNextRecordsWithError:&error];
            
            Record *record = [records2 objectAtIndex:0];
            NSLog(@"identifier = %@", record.recordHeader.identifier);
            NSLog(@"status = %i", record.recordHeader.status);
            NSLog(@"datestamp = %@", record.recordHeader.datestamp);
            for (NSString *set in record.recordHeader.setSpecs){
                NSLog(@"set = %@", set);
            }
            NSLog(@"namespace: %@", record.recordMetadata.namespce);
            NSLog(@"schemaLoacation: %@", record.recordMetadata.schemaLocation);
            for (MetadataElement *metadata in record.recordMetadata.metadataElements){
                NSLog(@"%@: %@", metadata.name, metadata.value);
            }
        }
    }

<br/>List records (2nd way - get all items at once):

	NSArray *records = [harvester listAllRecords error:&error];

Example
-----------

A fully detailed example can be found <a target="blank" href="https://github.com/kstamatis/iOS-OAI-PMH-Harvester">here</a>. It is an open-source iOS example of how to use this library in a real OAI-PMH enabled repository, the one of Serres Public Library.

Limitations
-----------
- No validation of the incoming xml
- No support for resumption tokens in the following verbs: <i>ListSets</i>
- No support for date selective harvesting for the verbs: <i>ListIdentifiers</i> and <i>ListRecords</i>
- No support for the "description" element in <i>Identify</i> verb
- No support for the "about" element in <i>ListRecords</i> verb

Dependencies
------------
The only dependency of this project is the <a target="_blank" href="https://github.com/TouchCode/TouchXML">TouchXML</a> library that can be found <a target="_blank" href="https://github.com/TouchCode/TouchXML">here</a>.

Author
------------
<b><a target="_blank" href="http://about.me/kstamatis">Kostas Stamatis</a></b><br/>
<a target="_blank" href="http://www.ekt.gr/">National Documentation Center</a> / <a target="_blank" href="http://www.eie.gr/">NHRF</a>

Licence
------------
<a target="_blank" rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">OAI-PMH ObjC Harvester</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Konstantinos Stamatis</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.