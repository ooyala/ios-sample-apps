/**
 * @class      OOAsyncTask OOAsyncTask.h "OOAsyncTask.h"
 * @brief      OOAsyncTask
 * @details    OOAsyncTask.h in OoyalaSDK
 * @date       1/31/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef void(^OOTask)(void);

@interface OOAsyncTask : NSObject

@property (nonatomic, copy) OOTask doInBackground;
@property (nonatomic, copy) OOTask onPostExecute;

- (void)execute;
- (void)cancel:(id)task;

@end
