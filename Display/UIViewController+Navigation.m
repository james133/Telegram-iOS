#import "UIViewController+Navigation.h"

#import "RuntimeUtils.h"
#import <objc/runtime.h>

#import "NSWeakReference.h"

@interface UIViewControllerPresentingProxy : UIViewController

@property (nonatomic, copy) void (^dismiss)();
@property (nonatomic, strong, readonly) UIViewController *rootController;

@end

@implementation UIViewControllerPresentingProxy

- (instancetype)initWithRootController:(UIViewController *)rootController {
    _rootController = rootController;
    return self;
}

- (void)dismissViewControllerAnimated:(BOOL)__unused flag completion:(void (^)(void))completion {
    if (_dismiss) {
        _dismiss();
    }
    if (completion) {
        completion();
    }
}

@end

static const void *UIViewControllerIgnoreAppearanceMethodInvocationsKey = &UIViewControllerIgnoreAppearanceMethodInvocationsKey;
static const void *UIViewControllerNavigationControllerKey = &UIViewControllerNavigationControllerKey;
static const void *UIViewControllerPresentingControllerKey = &UIViewControllerPresentingControllerKey;
static const void *UIViewControllerPresentingProxyControllerKey = &UIViewControllerPresentingProxyControllerKey;
static const void *disablesInteractiveTransitionGestureRecognizerKey = &disablesInteractiveTransitionGestureRecognizerKey;
static const void *disableAutomaticKeyboardHandlingKey = &disableAutomaticKeyboardHandlingKey;
static const void *setNeedsStatusBarAppearanceUpdateKey = &setNeedsStatusBarAppearanceUpdateKey;
static const void *inputAccessoryHeightProviderKey = &inputAccessoryHeightProviderKey;
static const void *interactiveTransitionGestureRecognizerTestKey = &interactiveTransitionGestureRecognizerTestKey;
static const void *UIViewControllerHintWillBePresentedInPreviewingContextKey = &UIViewControllerHintWillBePresentedInPreviewingContextKey;

static bool notyfyingShiftState = false;

@interface UIKeyboardImpl_65087dc8: UIView

@end

@implementation UIKeyboardImpl_65087dc8

- (void)notifyShiftState {
    static void (*impl)(id, SEL) = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m = class_getInstanceMethod([UIKeyboardImpl_65087dc8 class], @selector(notifyShiftState));
        impl = (typeof(impl))method_getImplementation(m);
    });
    if (impl) {
        notyfyingShiftState = true;
        impl(self, @selector(notifyShiftState));
        notyfyingShiftState = false;
    }
}

@end

@interface UIInputWindowController_65087dc8: UIViewController

@end

@implementation UIInputWindowController_65087dc8

- (void)updateViewConstraints {
    static void (*impl)(id, SEL) = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m = class_getInstanceMethod([UIInputWindowController_65087dc8 class], @selector(updateViewConstraints));
        impl = (typeof(impl))method_getImplementation(m);
    });
    if (impl) {
        if (!notyfyingShiftState) {
            impl(self, @selector(updateViewConstraints));
        }
    }
}

@end

@implementation UIViewController (Navigation)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        [RuntimeUtils swizzleInstanceMethodOfClass:[UIViewController class] currentSelector:@selector(viewWillAppear:) newSelector:@selector(_65087dc8_viewWillAppear:)];
        [RuntimeUtils swizzleInstanceMethodOfClass:[UIViewController class] currentSelector:@selector(viewDidAppear:) newSelector:@selector(_65087dc8_viewDidAppear:)];
        [RuntimeUtils swizzleInstanceMethodOfClass:[UIViewController class] currentSelector:@selector(viewWillDisappear:) newSelector:@selector(_65087dc8_viewWillDisappear:)];
        [RuntimeUtils swizzleInstanceMethodOfClass:[UIViewController class] currentSelector:@selector(viewDidDisappear:) newSelector:@selector(_65087dc8_viewDidDisappear:)];
        [RuntimeUtils swizzleInstanceMethodOfClass:[UIViewController class] currentSelector:@selector(navigationController) newSelector:@selector(_65087dc8_navigationController)];
        [RuntimeUtils swizzleInstanceMethodOfClass:[UIViewController class] currentSelector:@selector(presentingViewController) newSelector:@selector(_65087dc8_presentingViewController)];
        [RuntimeUtils swizzleInstanceMethodOfClass:[UIViewController class] currentSelector:@selector(presentViewController:animated:completion:) newSelector:@selector(_65087dc8_presentViewController:animated:completion:)];
        [RuntimeUtils swizzleInstanceMethodOfClass:[UIViewController class] currentSelector:@selector(setNeedsStatusBarAppearanceUpdate) newSelector:@selector(_65087dc8_setNeedsStatusBarAppearanceUpdate)];
        
        //[RuntimeUtils swizzleInstanceMethodOfClass:NSClassFromString(@"UIKeyboardImpl") currentSelector:@selector(notifyShiftState) withAnotherClass:[UIKeyboardImpl_65087dc8 class] newSelector:@selector(notifyShiftState)];
        //[RuntimeUtils swizzleInstanceMethodOfClass:NSClassFromString(@"UIInputWindowController") currentSelector:@selector(updateViewConstraints) withAnotherClass:[UIInputWindowController_65087dc8 class] newSelector:@selector(updateViewConstraints)];
    });
}

- (void)setHintWillBePresentedInPreviewingContext:(BOOL)value {
    [self setAssociatedObject:@(value) forKey:UIViewControllerHintWillBePresentedInPreviewingContextKey];
}

- (BOOL)isPresentedInPreviewingContext {
    if ([[self associatedObjectForKey:UIViewControllerHintWillBePresentedInPreviewingContextKey] boolValue]) {
        return true;
    } else {
        return false;
    }
}

- (void)setIgnoreAppearanceMethodInvocations:(BOOL)ignoreAppearanceMethodInvocations
{
    [self setAssociatedObject:@(ignoreAppearanceMethodInvocations) forKey:UIViewControllerIgnoreAppearanceMethodInvocationsKey];
}

- (BOOL)ignoreAppearanceMethodInvocations
{
    return [[self associatedObjectForKey:UIViewControllerIgnoreAppearanceMethodInvocationsKey] boolValue];
}

- (void)_65087dc8_viewWillAppear:(BOOL)animated
{
    if (![self ignoreAppearanceMethodInvocations])
        [self _65087dc8_viewWillAppear:animated];
}

- (void)_65087dc8_viewDidAppear:(BOOL)animated
{
    if (![self ignoreAppearanceMethodInvocations])
        [self _65087dc8_viewDidAppear:animated];
}

- (void)_65087dc8_viewWillDisappear:(BOOL)animated
{
    if (![self ignoreAppearanceMethodInvocations])
        [self _65087dc8_viewWillDisappear:animated];
}

- (void)_65087dc8_viewDidDisappear:(BOOL)animated
{
    if (![self ignoreAppearanceMethodInvocations])
        [self _65087dc8_viewDidDisappear:animated];
}

- (void)navigation_setNavigationController:(UINavigationController * _Nullable)navigationControlller {
    [self setAssociatedObject:[[NSWeakReference alloc] initWithValue:navigationControlller] forKey:UIViewControllerNavigationControllerKey];
}

- (UINavigationController *)_65087dc8_navigationController {
    UINavigationController *navigationController = self._65087dc8_navigationController;
    if (navigationController != nil) {
        return navigationController;
    }
    
    UIViewController *parentController = self.parentViewController;
    
    navigationController = parentController.navigationController;
    if (navigationController != nil) {
        return navigationController;
    }
    
    return ((NSWeakReference *)[self associatedObjectForKey:UIViewControllerNavigationControllerKey]).value;
}

- (void)navigation_setPresentingViewController:(UIViewController *)presentingViewController {
    [self setAssociatedObject:[[NSWeakReference alloc] initWithValue:presentingViewController] forKey:UIViewControllerPresentingControllerKey];
}

- (void)navigation_setDismiss:(void (^_Nullable)())dismiss rootController:(UIViewController *)rootController {
    UIViewControllerPresentingProxy *proxy = [[UIViewControllerPresentingProxy alloc] initWithRootController:rootController];
    proxy.dismiss = dismiss;
    [self setAssociatedObject:proxy forKey:UIViewControllerPresentingProxyControllerKey];
}

- (UIViewController *)_65087dc8_presentingViewController {
    UINavigationController *navigationController = self.navigationController;
    if (navigationController.presentingViewController != nil) {
        return navigationController.presentingViewController;
    }
    
    UIViewController *controller = ((NSWeakReference *)[self associatedObjectForKey:UIViewControllerPresentingControllerKey]).value;
    if (controller != nil) {
        return controller;
    }
    
    UIViewController *result = [self associatedObjectForKey:UIViewControllerPresentingProxyControllerKey];
    if (result != nil) {
        return result;
    }
    
    return [self _65087dc8_presentingViewController];
}

- (void)_65087dc8_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [self _65087dc8_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)_65087dc8_setNeedsStatusBarAppearanceUpdate {
    [self _65087dc8_setNeedsStatusBarAppearanceUpdate];
    
    void (^block)() = [self associatedObjectForKey:setNeedsStatusBarAppearanceUpdateKey];
    if (block) {
        block();
    }
}

- (void)state_setNeedsStatusBarAppearanceUpdate:(void (^_Nullable)())block {
    [self setAssociatedObject:[block copy] forKey:setNeedsStatusBarAppearanceUpdateKey];
}

@end

@implementation UIView (Navigation)

- (bool)disablesInteractiveTransitionGestureRecognizer {
    return [[self associatedObjectForKey:disablesInteractiveTransitionGestureRecognizerKey] boolValue];
}

- (void)setDisablesInteractiveTransitionGestureRecognizer:(bool)disablesInteractiveTransitionGestureRecognizer {
    [self setAssociatedObject:@(disablesInteractiveTransitionGestureRecognizer) forKey:disablesInteractiveTransitionGestureRecognizerKey];
}

- (BOOL (^)(CGPoint))interactiveTransitionGestureRecognizerTest {
    return [self associatedObjectForKey:interactiveTransitionGestureRecognizerTestKey];
}

- (void)setInteractiveTransitionGestureRecognizerTest:(BOOL (^)(CGPoint))block {
    [self setAssociatedObject:[block copy] forKey:interactiveTransitionGestureRecognizerTestKey];
}

- (UIResponderDisableAutomaticKeyboardHandling)disableAutomaticKeyboardHandling {
    return (UIResponderDisableAutomaticKeyboardHandling)[[self associatedObjectForKey:disableAutomaticKeyboardHandlingKey] unsignedIntegerValue];
}

- (void)setDisableAutomaticKeyboardHandling:(UIResponderDisableAutomaticKeyboardHandling)disableAutomaticKeyboardHandling {
    [self setAssociatedObject:@(disableAutomaticKeyboardHandling) forKey:disableAutomaticKeyboardHandlingKey];
}

- (void)input_setInputAccessoryHeightProvider:(CGFloat (^_Nullable)())block {
    [self setAssociatedObject:[block copy] forKey:inputAccessoryHeightProviderKey];
}

- (CGFloat)input_getInputAccessoryHeight {
    CGFloat (^block)() = [self associatedObjectForKey:inputAccessoryHeightProviderKey];
    if (block) {
        return block();
    }
    return 0.0f;
}

@end

static NSString *TGEncodeText(NSString *string, int key)
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (int i = 0; i < (int)[string length]; i++)
    {
        unichar c = [string characterAtIndex:i];
        c += key;
        [result appendString:[NSString stringWithCharacters:&c length:1]];
    }
    
    return result;
}

void applyKeyboardAutocorrection() {
    static Class keyboardClass = NULL;
    static SEL currentInstanceSelector = NULL;
    static SEL applyVariantSelector = NULL;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyboardClass = NSClassFromString(TGEncodeText(@"VJLfzcpbse", -1));
        
        currentInstanceSelector = NSSelectorFromString(TGEncodeText(@"bdujwfLfzcpbse", -1));
        applyVariantSelector = NSSelectorFromString(TGEncodeText(@"bddfquBvupdpssfdujpo", -1));
    });
    
    if ([keyboardClass respondsToSelector:currentInstanceSelector])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id currentInstance = [keyboardClass performSelector:currentInstanceSelector];
        if ([currentInstance respondsToSelector:applyVariantSelector])
            [currentInstance performSelector:applyVariantSelector];
#pragma clang diagnostic pop
    }
}
