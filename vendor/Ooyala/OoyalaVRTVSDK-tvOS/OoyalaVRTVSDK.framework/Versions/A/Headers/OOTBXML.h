// ================================================================================================
//  TBXML.h
//  Fast processing of XML files
//
// ================================================================================================
//  Created by Tom Bradley on 21/10/2009.
//  Version 1.4
//  
//  Copyright (c) 2009 Tom Bradley
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
// ================================================================================================


// ================================================================================================
//  Defines
// ================================================================================================
#define OO_TBXML_MAX_ELEMENTS 100
#define OO_TBXML_MAX_ATTRIBUTES 100

#define OO_TBXML_ATTRIBUTE_NAME_START 0
#define OO_TBXML_ATTRIBUTE_NAME_END 1
#define OO_TBXML_ATTRIBUTE_VALUE_START 2
#define OO_TBXML_ATTRIBUTE_VALUE_END 3
#define OO_TBXML_ATTRIBUTE_CDATA_END 4
#import <Foundation/Foundation.h>


// ================================================================================================
//  Structures
// ================================================================================================
typedef struct _OOTBXMLAttribute {
	char * name;
	char * value;
	struct _OOTBXMLAttribute * next;
} OOTBXMLAttribute;

typedef struct _OOTBXMLElement {
	char * name;
	char * text;
	
	OOTBXMLAttribute * firstAttribute;
	
	struct _OOTBXMLElement * parentElement;
	
	struct _OOTBXMLElement * firstChild;
	struct _OOTBXMLElement * currentChild;
	
	struct _OOTBXMLElement * nextSibling;
	struct _OOTBXMLElement * previousSibling;
	
} OOTBXMLElement;

typedef struct _OOTBXMLElementBuffer {
	OOTBXMLElement * elements;
	struct _OOTBXMLElementBuffer * next;
	struct _OOTBXMLElementBuffer * previous;
} OOTBXMLElementBuffer;

typedef struct _OOTBXMLAttributeBuffer {
	OOTBXMLAttribute * attributes;
	struct _OOTBXMLAttributeBuffer * next;
	struct _OOTBXMLAttributeBuffer * previous;
} OOTBXMLAttributeBuffer;

// ================================================================================================
//  TBXML Public Interface
// ================================================================================================
@interface OOTBXML : NSObject {
	
@private
	OOTBXMLElement * rootXMLElement;
	
	OOTBXMLElementBuffer * currentElementBuffer;
	OOTBXMLAttributeBuffer * currentAttributeBuffer;
	
	long currentElement;
	long currentAttribute;
	
	char * bytes;
	long bytesLength;
  NSArray * ignoredTags;
}

@property (nonatomic, readonly) OOTBXMLElement * rootXMLElement;

+ (id)tbxmlWithURL:(NSURL*)aURL;
+ (id)tbxmlWithURL:(NSURL*)aURL ignoredTags:(NSArray *)theIgnoredTags;
+ (id)tbxmlWithXMLString:(NSString*)aXMLString;
+ (id)tbxmlWithXMLString:(NSString*)aXMLString ignoredTags:(NSArray *)theIgnoredTags;
+ (id)tbxmlWithXMLData:(NSData*)aData;
+ (id)tbxmlWithXMLData:(NSData*)aData ignoredTags:(NSArray *)theIgnoredTags;
+ (id)tbxmlWithXMLFile:(NSString*)aXMLFile;
+ (id)tbxmlWithXMLFile:(NSString*)aXMLFile ignoredTags:(NSArray *)theIgnoredTags;
+ (id)tbxmlWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension;
+ (id)tbxmlWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension ignoredTags:(NSArray *)theIgnoredTags;

- (id)initWithURL:(NSURL*)aURL;
- (id)initWithURL:(NSURL*)aURL ignoredTags:(NSArray *)theIgnoredTags;
- (id)initWithXMLString:(NSString*)aXMLString;
- (id)initWithXMLString:(NSString*)aXMLString ignoredTags:(NSArray *)theIgnoredTags;
- (id)initWithXMLData:(NSData*)aData;
- (id)initWithXMLData:(NSData*)aData ignoredTags:(NSArray *)theIgnoredTags;
- (id)initWithXMLFile:(NSString*)aXMLFile;
- (id)initWithXMLFile:(NSString*)aXMLFile ignoredTags:(NSArray *)theIgnoredTags;
- (id)initWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension;
- (id)initWithXMLFile:(NSString*)aXMLFile fileExtension:(NSString*)aFileExtension ignoredTags:(NSArray *)theIgnoredTags;

@end

// ================================================================================================
//  TBXML Static Functions Interface
// ================================================================================================

@interface OOTBXML (StaticFunctions)

+ (NSString*) elementName:(OOTBXMLElement*)aXMLElement;
+ (NSString*) textForElement:(OOTBXMLElement*)aXMLElement;
+ (NSString*) valueOfAttributeNamed:(NSString *)aName forElement:(OOTBXMLElement*)aXMLElement;

+ (NSString*) attributeName:(OOTBXMLAttribute*)aXMLAttribute;
+ (NSString*) attributeValue:(OOTBXMLAttribute*)aXMLAttribute;

+ (OOTBXMLElement*) nextSiblingNamed:(NSString*)aName searchFromElement:(OOTBXMLElement*)aXMLElement;
+ (OOTBXMLElement*) childElementNamed:(NSString*)aName parentElement:(OOTBXMLElement*)aParentXMLElement;

@end
