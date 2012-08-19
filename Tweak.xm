%hook UIImageView
- (id)initWithImage:(id)arg1
{
  self = %orig;
  //NSLog(@"frame = %@", NSStringFromCGRect(self.frame));

  // FIXME: Better way detect verticalScrollIndicator.
  // NOTE: Normally rect is (0,0,7,7) but twitter.app is (0,0,5,5)
  //       And not compatible Instagram's (0,0,3,3) why?
  if (self.frame.origin.x == 0 && self.frame.origin.y == 0 && self.frame.size.width <= 7 && self.frame.size.height <= 7) {
    CGRect frame = self.frame;
    frame.size.width /= 2;
    self.frame = frame;
  }
  return self;
}
%end

/*
%hook UIScrollView
- (BOOL)_canScrollY
{
  UIImageView *vScrollIndicator = MSHookIvar<UIImageView*>(self, "_verticalScrollIndicator");
  NSLog(@"vsi = %@", vScrollIndicator);
  if (vScrollIndicator) {
    CGRect rect = vScrollIndicator.frame;
    rect.size.width /= 2;
    vScrollIndicator.frame = rect;
  }
  return %orig;
}
%end
*/
