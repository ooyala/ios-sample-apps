/**
 * @headerfile OOReturnState.h "OOReturnState.h"
 * @brief      OOReturnState
 * @details    OOReturnState.h in OoyalaSDK
 * @author     Jigish Patel
 * @date       2/2/12
 * @copyright  Copyright (c) 2012 Ooyala, Inc. All rights reserved.
 */

#ifndef OoyalaSDK_ReturnState_h
#define OoyalaSDK_ReturnState_h

/** @internal
 * Possible return states for update methods
 */
typedef enum {
  OOReturnStateMatched,                                           /**< @internal Found a match (success) */
  OOReturnStateUnmatched,                                         /**< @internal No match found, but no errors either */
  OOReturnStateFail                                               /**< @internal Error case */
} OOReturnState;

#endif
