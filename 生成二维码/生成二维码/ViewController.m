//
//  ViewController.m
//  生成二维码
//
//  Created by ShenYj on 16/8/23.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "ViewController.h"
// #import <CoreImage/CoreImage.h> 可以不用导入直接使用

@interface ViewController ()

@end

@implementation ViewController{
    
    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    /*      Categories:
    CORE_IMAGE_EXPORT NSString * const kCICategoryDistortionEffect;
    CORE_IMAGE_EXPORT NSString * const kCICategoryGeometryAdjustment;
    CORE_IMAGE_EXPORT NSString * const kCICategoryCompositeOperation;
    CORE_IMAGE_EXPORT NSString * const kCICategoryHalftoneEffect;
    CORE_IMAGE_EXPORT NSString * const kCICategoryColorAdjustment;--->颜色
    CORE_IMAGE_EXPORT NSString * const kCICategoryColorEffect;
    CORE_IMAGE_EXPORT NSString * const kCICategoryTransition;
    CORE_IMAGE_EXPORT NSString * const kCICategoryTileEffect;
    CORE_IMAGE_EXPORT NSString * const kCICategoryGenerator;
    CORE_IMAGE_EXPORT NSString * const kCICategoryReduction NS_AVAILABLE(10_5, 5_0);
    CORE_IMAGE_EXPORT NSString * const kCICategoryGradient;   --->渐变
    CORE_IMAGE_EXPORT NSString * const kCICategoryStylize;    --->风格化
    CORE_IMAGE_EXPORT NSString * const kCICategorySharpen;    --->锐化
    CORE_IMAGE_EXPORT NSString * const kCICategoryBlur;       --->高斯模糊
    CORE_IMAGE_EXPORT NSString * const kCICategoryVideo;
    CORE_IMAGE_EXPORT NSString * const kCICategoryStillImage;
    CORE_IMAGE_EXPORT NSString * const kCICategoryInterlaced;
    CORE_IMAGE_EXPORT NSString * const kCICategoryNonSquarePixels;
    CORE_IMAGE_EXPORT NSString * const kCICategoryHighDynamicRange;
    CORE_IMAGE_EXPORT NSString * const kCICategoryBuiltIn;     ---> 内嵌
    CORE_IMAGE_EXPORT NSString * const kCICategoryFilterGenerator NS_AVAILABLE(10_5, 9_0);
     */
    
    // 获取CoreImage分类中的滤镜
//    NSArray *filterArr = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
//    // 打印kCICategoryBuiltIn中包含的滤镜
//    NSLog(@"%@",filterArr);
//    
    /*
     
     CIAccordionFoldTransition,
     CIAdditionCompositing,
     CIAffineClamp,
     CIAffineTile,
     CIAffineTransform,
     CIAreaAverage,
     CIAreaHistogram,
     CIAreaMaximum,
     CIAreaMaximumAlpha,
     CIAreaMinimum,
     CIAreaMinimumAlpha,
     CIAztecCodeGenerator,
     CIBarsSwipeTransition,
     CIBlendWithAlphaMask,
     CIBlendWithMask,
     CIBloom,
     CIBoxBlur,
     CIBumpDistortion,
     CIBumpDistortionLinear,
     CICheckerboardGenerator,
     CICircleSplashDistortion,
     CICircularScreen,
     CICircularWrap,
     CICMYKHalftone,
     CICode128BarcodeGenerator,
     CIColorBlendMode,
     CIColorBurnBlendMode,
     CIColorClamp,
     CIColorControls,
     CIColorCrossPolynomial,
     CIColorCube,
     CIColorCubeWithColorSpace,
     CIColorDodgeBlendMode,
     CIColorInvert,
     CIColorMap,
     CIColorMatrix,
     CIColorMonochrome,
     CIColorPolynomial,
     CIColorPosterize,
     CIColumnAverage,
     CIComicEffect,
     CIConstantColorGenerator,
     CIConvolution3X3,
     CIConvolution5X5,
     CIConvolution7X7,
     CIConvolution9Horizontal,
     CIConvolution9Vertical,
     CICopyMachineTransition,
     CICrop,
     CICrystallize,
     CIDarkenBlendMode,
     CIDepthOfField,
     CIDifferenceBlendMode,
     CIDiscBlur,
     CIDisintegrateWithMaskTransition,
     CIDisplacementDistortion,
     CIDissolveTransition,
     CIDivideBlendMode,
     CIDotScreen,
     CIDroste,
     CIEdges,
     CIEdgeWork,
     CIEightfoldReflectedTile,
     CIExclusionBlendMode,
     CIExposureAdjust,
     CIFalseColor,
     CIFlashTransition,
     CIFourfoldReflectedTile,
     CIFourfoldRotatedTile,
     CIFourfoldTranslatedTile,
     CIGammaAdjust,
     CIGaussianBlur,
     CIGaussianGradient,
     CIGlassDistortion,
     CIGlassLozenge,
     CIGlideReflectedTile,
     CIGloom,
     CIHardLightBlendMode,
     CIHatchedScreen,
     CIHeightFieldFromMask,
     CIHexagonalPixellate,
     CIHighlightShadowAdjust,
     CIHistogramDisplayFilter,
     CIHoleDistortion,
     CIHueAdjust,
     CIHueBlendMode,
     CIKaleidoscope,
     CILanczosScaleTransform,
     CILenticularHaloGenerator,
     CILightenBlendMode,
     CILightTunnel,
     CILinearBurnBlendMode,
     CILinearDodgeBlendMode,
     CILinearGradient,
     CILinearToSRGBToneCurve,
     CILineOverlay,
     CILineScreen,
     CILuminosityBlendMode,
     CIMaskedVariableBlur,
     CIMaskToAlpha,
     CIMaximumComponent,
     CIMaximumCompositing,
     CIMedianFilter,
     CIMinimumComponent,
     CIMinimumCompositing,
     CIModTransition,
     CIMotionBlur,
     CIMultiplyBlendMode,
     CIMultiplyCompositing,
     CINoiseReduction,
     CIOpTile,
     CIOverlayBlendMode,
     CIPageCurlTransition,
     CIPageCurlWithShadowTransition,
     CIParallelogramTile,
     CIPDF417BarcodeGenerator,
     CIPerspectiveCorrection,
     CIPerspectiveTile,
     CIPerspectiveTransform,
     CIPerspectiveTransformWithExtent,
     CIPhotoEffectChrome,
     CIPhotoEffectFade,
     CIPhotoEffectInstant,
     CIPhotoEffectMono,
     CIPhotoEffectNoir,
     CIPhotoEffectProcess,
     CIPhotoEffectTonal,
     CIPhotoEffectTransfer,
     CIPinchDistortion,
     CIPinLightBlendMode,
     CIPixellate,
     CIPointillize,
     CIQRCodeGenerator,
     CIRadialGradient,
     CIRandomGenerator,
     CIRippleTransition,
     CIRowAverage,
     CISaturationBlendMode,
     CIScreenBlendMode,
     CISepiaTone,
     CIShadedMaterial,
     CISharpenLuminance,
     CISixfoldReflectedTile,
     CISixfoldRotatedTile,
     CISmoothLinearGradient,
     CISoftLightBlendMode,
     CISourceAtopCompositing,
     CISourceInCompositing,
     CISourceOutCompositing,
     CISourceOverCompositing,
     CISpotColor,
     CISpotLight,
     CISRGBToneCurveToLinear,
     CIStarShineGenerator,
     CIStraightenFilter,
     CIStretchCrop,
     CIStripesGenerator,
     CISubtractBlendMode,
     CISunbeamsGenerator,
     CISwipeTransition,
     CITemperatureAndTint,
     CIToneCurve,
     CITorusLensDistortion,
     CITriangleKaleidoscope,
     CITriangleTile,
     CITwelvefoldReflectedTile,
     CITwirlDistortion,
     CIUnsharpMask,
     CIVibrance,
     CIVignette,
     CIVignetteEffect,
     CIVortexDistortion,
     CIWhitePointAdjust,
     CIZoomBlur
     
     */
    
    /*
    @property (readonly, nonatomic, nullable) CIImage *outputImage; // 生成的图片
    @property (nonatomic, readonly) NSString *name
    @property (nonatomic, copy) NSString *name
    @property (getter=isEnabled) BOOL enabled
    @property (nonatomic, readonly) CI_ARRAY(NSString*) *inputKeys; // 输入内容的设置
             inputMessage          -    输入信息
             inputCorrectionLevel  -    容错等级
    @property (nonatomic, readonly) CI_ARRAY(NSString*) *outputKeys;// 输出内容的设置
    @property (nonatomic, readonly) CI_DICTIONARY(NSString*,id) *attributes;
     - (void)setDefaults; // 设置默认的
     */
    
    // 1.创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.设置属性  首先要设置默认选项
    [filter setDefaults];
    // NSLog(@"%@",filter.inputKeys);
    
    NSString *inputContent = @"生成二维码";
    [filter setValue:[inputContent dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    
    /* 细节1:
     [filter setValue:@"生成二维码" forKey:@"inputMessage"];这种方式设置会报错:
      - Terminating app due to uncaught exception 'CIQRCodeGenerator', reason: 'CIQRCodeGenerator filter requires NSData for inputMessage'
     */
    
    // 3.根据滤镜生成图片
    CIImage *image = filter.outputImage;
    
    /* 细节2:
       设置尺寸,防止图片尺寸小于图片框导致放大模糊
     */
    image = [image imageByApplyingTransform:CGAffineTransformMakeScale(8, 8)];
    
    // 展示生成的二维码
    _imageView.image = [UIImage imageWithCIImage:image];
    
}

@end
