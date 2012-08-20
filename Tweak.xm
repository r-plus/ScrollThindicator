@interface UIImage(Private)
- (BOOL)_isResizable;
@end

%hook UIImageView
- (id)initWithImage:(id)arg1
{
  self = %orig;

  // FIXME: Better way detect verticalScrollIndicator.
  // NOTE: Normally rect is (0,0,7,7) but twitter.app is (0,0,5,5)
  //       And not compatible Instagram's (0,0,3,3) why?
  if (self.frame.origin.x == 0 && self.frame.origin.y == 0 && self.frame.size.width <= 7 && self.frame.size.height <= 7) {
    if ([self.image _isResizable]) {
      CGRect frame = self.frame;
      frame.size.width /= 2;
      self.frame = frame;
    }
  }
  return self;
}
%end

%hook UIScrollView
- (BOOL)_canScrollX
{
  UIImageView *hScrollIndicator = MSHookIvar<UIImageView*>(self, "_horizontalScrollIndicator");
  if (hScrollIndicator && hScrollIndicator.frame.size.height == 7 && [hScrollIndicator.image _isResizable]) {
    CGRect rect = hScrollIndicator.frame;
    rect.size.height /= 2;
    hScrollIndicator.frame = rect;
  }
  return %orig;
}
%end
