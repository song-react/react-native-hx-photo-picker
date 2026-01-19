import type { HybridObject } from 'react-native-nitro-modules';
export type Color = string;
export interface Size {
    width: number;
    height: number;
}
export interface EdgeInsets {
    top: number;
    left: number;
    bottom: number;
    right: number;
}
export type FontFamilyOption = 'system' | 'pingfang';
export type FontWeightOption = 'ultraLight' | 'thin' | 'light' | 'regular' | 'medium' | 'semibold' | 'bold' | 'heavy' | 'black';
export interface FontConfig {
    size: number;
    weight?: FontWeightOption;
    family?: FontFamilyOption;
    name?: string;
}
export type MediaType = 'photo' | 'video';
export type PickerAssetOption = 'photo' | 'video' | 'gifPhoto' | 'livePhoto' | 'HDRPhoto';
export type PickerSelectModeOption = 'single' | 'multiple';
export type PickerPresentStyleOption = 'none' | 'present' | 'push';
export type AlbumShowModeOption = 'normal' | 'popup' | 'present';
export type AppearanceStyleOption = 'varied' | 'normal' | 'dark';
export type StatusBarStyleOption = 'default' | 'lightContent' | 'darkContent';
export type BarStyleOption = 'default' | 'black';
export type ModalPresentationStyleOption = 'fullScreen' | 'pageSheet' | 'formSheet' | 'currentContext' | 'custom' | 'overFullScreen' | 'overCurrentContext' | 'popover' | 'automatic';
export type InterfaceOrientationOption = 'portrait' | 'portraitUpsideDown' | 'landscapeLeft' | 'landscapeRight';
export type SelectionTapActionOption = 'preview' | 'quickSelect' | 'openEditor';
export type SortOption = 'asc' | 'desc';
export type PhotoPickerPreviewJumpStyleOption = 'push' | 'present';
export type IndicatorTypeOption = 'circle' | 'circleJoin' | 'system';
export type SelectBoxStyleOption = 'number' | 'tick';
export type ActivityIndicatorStyleOption = 'gray' | 'white' | 'large' | 'medium';
export type PreviewPlayTypeOption = 'normal' | 'auto' | 'once';
export type LoadNetworkVideoModeOption = 'download' | 'play';
export type BlurEffectStyleOption = 'extraLight' | 'light' | 'dark' | 'regular' | 'prominent' | 'systemUltraThinMaterial' | 'systemThinMaterial' | 'systemMaterial' | 'systemThickMaterial' | 'systemChromeMaterial';
export type EditorButtonTypeOption = 'top' | 'bottom';
export type EditorToolOption = 'time' | 'graffiti' | 'chartlet' | 'text' | 'mosaic' | 'filterEdit' | 'filter' | 'music' | 'cropSize';
export type EditorChartletLoadSceneOption = 'cellDisplay' | 'scrollStop';
export type EditorMaskTypeOption = 'blurEffect' | 'customColor';
export type EditorJumpStyleOption = 'push' | 'present';
export type EditorJumpPushStyleOption = 'normal' | 'custom';
export type EditorJumpPresentStyleOption = 'automatic' | 'fullScreen' | 'custom';
export type ExportPresetOption = 'lowQuality' | 'mediumQuality' | 'highQuality' | 'ratio_640x480' | 'ratio_960x540' | 'ratio_1280x720';
export type SystemCameraMediaTypeOption = 'image' | 'video';
export type SystemCameraDeviceOption = 'rear' | 'front';
export type SystemCameraVideoQualityOption = 'typeHigh' | 'typeMedium' | 'typeLow' | 'type640x480' | 'typeIFrame960x540' | 'typeIFrame1280x720';
export type CameraDevicePositionOption = 'back' | 'front';
export type CameraTakePhotoModeOption = 'press' | 'click';
export type CameraAspectRatioOption = 'fullScreen' | 'ratio9x16' | 'ratio16x9' | 'ratio3x4' | 'ratio1x1' | 'custom';
export type CameraPresetOption = 'vga640x480' | 'iFrame960x540' | 'hd1280x720' | 'hd1920x1080' | 'hd4K3840x2160';
export type CameraFlashModeOption = 'off' | 'on' | 'auto';
export type CameraVideoCodecTypeOption = 'h264' | 'hevc';
export type PhotoListCameraTypeOption = 'system' | 'custom';
export type PhotoListSaveSystemAlbumTypeOption = 'none' | 'displayName' | 'custom';
export type PickerViewCancelTypeOption = 'text' | 'image';
export type PickerViewCancelPositionOption = 'left' | 'right';
export type LanguageTypeOption = 'system' | 'simplifiedChinese' | 'traditionalChinese' | 'japanese' | 'korean' | 'english' | 'thai' | 'indonesia' | 'vietnamese' | 'russian' | 'german' | 'french' | 'arabic' | 'spanish' | 'portuguese' | 'amharic' | 'bengali' | 'divehi' | 'persian' | 'filipino' | 'hausa' | 'hebrew' | 'hindi' | 'italian' | 'malay' | 'nepali' | 'punjabi' | 'sinhala' | 'swahili' | 'syriac' | 'turkish' | 'ukrainian' | 'urdu';
export type EditorURLPathTypeOption = 'document' | 'caches' | 'temp';
export interface PickerPresentStyleConfig {
    type?: PickerPresentStyleOption;
    rightSwipeTriggerRange?: number;
}
export interface AlbumShowModeConfig {
    type?: AlbumShowModeOption;
    modalPresentationStyle?: ModalPresentationStyleOption;
}
export interface EditorJumpStyleConfig {
    type?: EditorJumpStyleOption;
    pushStyle?: EditorJumpPushStyleOption;
    presentStyle?: EditorJumpPresentStyleOption;
}
export interface EditorMaskTypeConfig {
    type?: EditorMaskTypeOption;
    blurStyle?: BlurEffectStyleOption;
    color?: Color;
}
export interface SelectBoxConfig {
    size?: Size;
    style?: SelectBoxStyleOption;
    titleFontSize?: number;
    titleColor?: Color;
    titleDarkColor?: Color;
    tickWidth?: number;
    tickColor?: Color;
    tickDarkColor?: Color;
    backgroundColor?: Color;
    darkBackgroundColor?: Color;
    selectedBackgroundColor?: Color;
    selectedBackgroudDarkColor?: Color;
    borderWidth?: number;
    borderColor?: Color;
    borderDarkColor?: Color;
}
export interface PhotoListCellConfig {
    isShowICloudMark?: boolean;
    backgroundColor?: Color;
    backgroundDarkColor?: Color;
    targetWidth?: number;
    isShowDisableMask?: boolean;
    isHiddenSingleVideoSelect?: boolean;
    selectBoxTopMargin?: number;
    selectBoxRightMargin?: number;
    selectBox?: SelectBoxConfig;
    isShowLivePhotoControl?: boolean;
    isPlayLivePhoto?: boolean;
    kf_indicatorColor?: Color;
}
export interface PhotoListCameraCellConfig {
    allowPreview?: boolean;
    backgroundColor?: Color;
    backgroundDarkColor?: Color;
    cameraImageName?: string;
    cameraDarkImageName?: string;
}
export interface PhotoListLimitCellConfig {
    backgroundColor?: Color;
    backgroundDarkColor?: Color;
    lineColor?: Color;
    lineDarkColor?: Color;
    lineWidth?: number;
    lineLength?: number;
    title?: string;
    titleColor?: Color;
    titleDarkColor?: Color;
    titleFont?: FontConfig;
}
export interface PhotoListAssetNumberConfig {
    textColor?: Color;
    textDarkColor?: Color;
    textFont?: FontConfig;
    filterTitleColor?: Color;
    filterTitleDarkColor?: Color;
    filterContentColor?: Color;
    filterContentDarkColor?: Color;
    filterFont?: FontConfig;
}
export interface PhotoListSaveSystemAlbumTypeConfig {
    type?: PhotoListSaveSystemAlbumTypeOption;
    customAlbumName?: string;
}
export interface EmptyViewConfig {
    titleColor?: Color;
    titleDarkColor?: Color;
    subTitleColor?: Color;
    subTitleDarkColor?: Color;
}
export interface ArrowViewConfig {
    backgroundColor?: Color;
    arrowColor?: Color;
    backgroudDarkColor?: Color;
    arrowDarkColor?: Color;
}
export interface AlbumTitleViewConfig {
    backgroundColor?: Color;
    backgroudDarkColor?: Color;
    arrow?: ArrowViewConfig;
}
export interface AlbumListConfig {
    limitedStatusPromptColor?: Color;
    limitedStatusPromptDarkColor?: Color;
    backgroundColor?: Color;
    backgroundDarkColor?: Color;
    splitBackgroundColor?: Color;
    splitBackgroundDarkColor?: Color;
    cellHeight?: number;
    splitCellHeight?: number;
    cellBackgroundColor?: Color;
    cellBackgroundDarkColor?: Color;
    cellSelectedColor?: Color;
    cellSelectedDarkColor?: Color;
    albumNameColor?: Color;
    albumNameDarkColor?: Color;
    albumNameFont?: FontConfig;
    photoCountColor?: Color;
    photoCountDarkColor?: Color;
    isShowPhotoCount?: boolean;
    photoCountFont?: FontConfig;
    separatorLineColor?: Color;
    separatorLineDarkColor?: Color;
    tickColor?: Color;
    tickDarkColor?: Color;
}
export interface PhotoAlbumControllerConfig {
    limitedStatusPromptColor?: Color;
    limitedStatusPromptDarkColor?: Color;
    backgroundColor?: Color;
    backgroundDarkColor?: Color;
    cellBackgroundColor?: Color;
    cellBackgroundDarkColor?: Color;
    cellSelectedColor?: Color;
    cellSelectedDarkColor?: Color;
    headerTitleColor?: Color;
    headerTitleDarkColor?: Color;
    headerTitleFont?: FontConfig;
    headerButtonTitleColor?: Color;
    headerButtonTitleDarkColor?: Color;
    headerButtonTitleFont?: FontConfig;
    albumNameColor?: Color;
    albumNameDarkColor?: Color;
    albumNameFont?: FontConfig;
    photoCountColor?: Color;
    photoCountDarkColor?: Color;
    isShowPhotoCount?: boolean;
    photoCountFont?: FontConfig;
    separatorLineColor?: Color;
    separatorLineDarkColor?: Color;
    imageColor?: Color;
    imageDarkColor?: Color;
    mediaTitleColor?: Color;
    mediaTitleDarkColor?: Color;
    mediaTitleFont?: FontConfig;
    mediaCountColor?: Color;
    mediaCountDarkColor?: Color;
    mediaCountFont?: FontConfig;
    arrowColor?: Color;
    arrowDarkColor?: Color;
}
export interface NotAuthorizedConfig {
    backgroundColor?: Color;
    darkBackgroundColor?: Color;
    closeButtonImageName?: string;
    closeButtonDarkImageName?: string;
    closeButtonColor?: Color;
    closeButtonDarkColor?: Color;
    isHiddenCloseButton?: boolean;
    titleColor?: Color;
    titleDarkColor?: Color;
    subTitleColor?: Color;
    darkSubTitleColor?: Color;
    jumpButtonBackgroundColor?: Color;
    jumpButtonDarkBackgroundColor?: Color;
    jumpButtonTitleColor?: Color;
    jumpButtonTitleDarkColor?: Color;
}
export interface PickerBottomViewConfig {
    backgroundColor?: Color;
    backgroundDarkColor?: Color;
    barTintColor?: Color;
    barTintDarkColor?: Color;
    isTranslucent?: boolean;
    barStyle?: BarStyleOption;
    barDarkStyle?: BarStyleOption;
    isHiddenPreviewButton?: boolean;
    previewButtonTitleColor?: Color;
    previewButtonTitleDarkColor?: Color;
    previewButtonDisableTitleColor?: Color;
    previewButtonDisableTitleDarkColor?: Color;
    isHiddenOriginalButton?: boolean;
    originalButtonTitleColor?: Color;
    originalButtonTitleDarkColor?: Color;
    isShowOriginalFileSize?: boolean;
    originalLoadingStyle?: ActivityIndicatorStyleOption;
    originalLoadingDarkStyle?: ActivityIndicatorStyleOption;
    originalSelectBox?: SelectBoxConfig;
    finishButtonTitleColor?: Color;
    finishButtonTitleDarkColor?: Color;
    finishButtonDisableTitleColor?: Color;
    finishButtonDisableTitleDarkColor?: Color;
    finishButtonBackgroundColor?: Color;
    finishButtonDarkBackgroundColor?: Color;
    finishButtonDisableBackgroundColor?: Color;
    finishButtonDisableDarkBackgroundColor?: Color;
    disableFinishButtonWhenNotSelected?: boolean;
    isHiddenEditButton?: boolean;
    editButtonTitleColor?: Color;
    editButtonTitleDarkColor?: Color;
    editButtonDisableTitleColor?: Color;
    editButtonDisableTitleDarkColor?: Color;
    isShowPrompt?: boolean;
    promptIconColor?: Color;
    promptIconDarkColor?: Color;
    promptTitleColor?: Color;
    promptTitleDarkColor?: Color;
    promptArrowColor?: Color;
    promptArrowDarkColor?: Color;
    isShowPreviewList?: boolean;
    previewListTickColor?: Color;
    previewListTickBgColor?: Color;
    previewListTickDarkColor?: Color;
    previewListTickBgDarkColor?: Color;
    isShowSelectedView?: boolean;
    selectedViewTickColor?: Color;
    selectedViewTickDarkColor?: Color;
}
export interface PreviewViewLivePhotoMarkConfig {
    allowShow?: boolean;
    blurStyle?: BlurEffectStyleOption;
    blurDarkStyle?: BlurEffectStyleOption;
    imageColor?: Color;
    textColor?: Color;
    imageDarkColor?: Color;
    textDarkColor?: Color;
    allowMutedShow?: boolean;
    mutedImageColor?: Color;
    mutedImageDarkColor?: Color;
}
export interface PreviewViewHDRMarkConfig {
    allowShow?: boolean;
    blurStyle?: BlurEffectStyleOption;
    blurDarkStyle?: BlurEffectStyleOption;
    imageColor?: Color;
    imageDarkColor?: Color;
}
export interface PreviewViewConfig {
    loadNetworkVideoMode?: LoadNetworkVideoModeOption;
    backgroundColor?: Color;
    backgroundDarkColor?: Color;
    statusBarHiddenBgColor?: Color;
    selectBox?: SelectBoxConfig;
    disableFinishButtonWhenNotSelected?: boolean;
    videoPlayType?: PreviewPlayTypeOption;
    livePhotoPlayType?: PreviewPlayTypeOption;
    livePhotoMark?: PreviewViewLivePhotoMarkConfig;
    HDRMark?: PreviewViewHDRMarkConfig;
    singleClickCellAutoPlayVideo?: boolean;
    maximumZoomScale?: number;
    isShowBottomView?: boolean;
    bottomView?: PickerBottomViewConfig;
    cancelType?: PickerViewCancelTypeOption;
    cancelPosition?: PickerViewCancelPositionOption;
    cancelImageName?: string;
    cancelDarkImageName?: string;
}
export interface SystemCameraConfig {
    mediaTypes?: SystemCameraMediaTypeOption[];
    videoMaximumDuration?: number;
    videoQuality?: SystemCameraVideoQualityOption;
    editExportPreset?: ExportPresetOption;
    editVideoQuality?: number;
    cameraDevice?: SystemCameraDeviceOption;
    allowsEditing?: boolean;
}
export interface CameraAspectRatioConfig {
    type?: CameraAspectRatioOption;
    size?: Size;
}
export interface CameraConfig {
    modalPresentationStyle?: ModalPresentationStyleOption;
    languageType?: LanguageTypeOption;
    prefersStatusBarHidden?: boolean;
    shouldAutorotate?: boolean;
    isAutoBack?: boolean;
    supportedInterfaceOrientations?: InterfaceOrientationOption[];
    indicatorType?: IndicatorTypeOption;
    isSaveSystemAlbum?: boolean;
    saveSystemAlbumType?: PhotoListSaveSystemAlbumTypeConfig;
    sessionPreset?: CameraPresetOption;
    aspectRatio?: CameraAspectRatioConfig;
    position?: CameraDevicePositionOption;
    flashMode?: CameraFlashModeOption;
    videoCodecType?: CameraVideoCodecTypeOption;
    videoMaximumDuration?: number;
    videoMinimumDuration?: number;
    takePhotoMode?: CameraTakePhotoModeOption;
    tintColor?: Color;
    focusColor?: Color;
    videoMaxZoomScale?: number;
    allowsEditing?: boolean;
    allowLocation?: boolean;
}
export interface PhotoListCameraTypeConfig {
    type?: PhotoListCameraTypeOption;
    systemConfig?: SystemCameraConfig;
    customConfig?: CameraConfig;
}
export interface PhotoListConfig {
    titleView?: AlbumTitleViewConfig;
    sort?: SortOption;
    backgroundColor?: Color;
    backgroundDarkColor?: Color;
    cancelImageName?: string;
    cancelDarkImageName?: string;
    isShowFilterItem?: boolean;
    filterThemeColor?: Color;
    filterThemeDarkColor?: Color;
    rowNumber?: number;
    landscapeRowNumber?: number;
    spltRowNumber?: number;
    spacing?: number;
    allowHapticTouchPreview?: boolean;
    allowAddMenuElements?: boolean;
    allowSwipeToSelect?: boolean;
    swipeSelectAllowAutoScroll?: boolean;
    swipeSelectIgnoreLeftArea?: number;
    swipeSelectScrollSpeed?: number;
    autoSwipeTopAreaHeight?: number;
    autoSwipeBottomAreaHeight?: number;
    cell?: PhotoListCellConfig;
    bottomView?: PickerBottomViewConfig;
    allowAddCamera?: boolean;
    cameraCell?: PhotoListCameraCellConfig;
    finishSelectionAfterTakingPhoto?: boolean;
    cameraType?: PhotoListCameraTypeConfig;
    takePictureCompletionToSelected?: boolean;
    isSaveSystemAlbum?: boolean;
    saveSystemAlbumType?: PhotoListSaveSystemAlbumTypeConfig;
    allowAddLimit?: boolean;
    limitCell?: PhotoListLimitCellConfig;
    isShowAssetNumber?: boolean;
    assetNumber?: PhotoListAssetNumberConfig;
    emptyView?: EmptyViewConfig;
    previewStyle?: PhotoPickerPreviewJumpStyleOption;
    selectedAssetIdentifier?: string;
}
export interface EditorURLConfig {
    fileName: string;
    pathType: EditorURLPathTypeOption;
}
export interface EditorRatioConfig {
    title: string;
    titleNormalColor?: Color;
    titleSelectedColor?: Color;
    backgroundNormalColor?: Color;
    backgroundSelectedColor?: Color;
    ratio: Size;
}
export interface EditorBrushConfig {
    colors?: string[];
    defaultColorIndex?: number;
    lineWidth?: number;
    maximumLinewidth?: number;
    minimumLinewidth?: number;
    showSlider?: boolean;
    addCustomColor?: boolean;
    customDefaultColor?: Color;
    isHideStickersDuringDrawing?: boolean;
}
export interface EditorFilterConfig {
    selectedColor?: Color;
    identifier?: string;
}
export interface EditorPhotoConfig {
    scale?: number;
    defaultSelectedToolOption?: EditorToolOption;
    filterScale?: number;
    filter?: EditorFilterConfig;
}
export interface EditorVideoCropTimeConfig {
    maximumTime?: number;
    minimumTime?: number;
    arrowNormalColor?: Color;
    arrowHighlightedColor?: Color;
    frameHighlightedColor?: Color;
}
export interface EditorMusicConfig {
    showSearch?: boolean;
    tintColor?: Color;
    finishButtonTitleColor?: Color;
    finishButtonBackgroundColor?: Color;
    placeholder?: string;
    autoPlayWhenScrollingStops?: boolean;
}
export interface EditorVideoConfig {
    preset?: ExportPresetOption;
    quality?: number;
    isAutoPlay?: boolean;
    defaultSelectedToolOption?: EditorToolOption;
    music?: EditorMusicConfig;
    cropTime?: EditorVideoCropTimeConfig;
    filter?: EditorFilterConfig;
}
export interface EditorTextConfig {
    colors?: string[];
    tintColor?: Color;
    doneTitleColor?: Color;
    doneBackgroundColor?: Color;
    font?: FontConfig;
    maximumLimitTextLength?: number;
    modalPresentationStyle?: ModalPresentationStyleOption;
}
export interface EditorMosaicConfig {
    mosaicWidth?: number;
    mosaiclineWidth?: number;
    smearWidth?: number;
    isFilterApply?: boolean;
    isHideStickersDuringDrawing?: boolean;
}
export interface EditorChartletConfig {
    modalPresentationStyle?: ModalPresentationStyleOption;
    rowCount?: number;
    loadScene?: EditorChartletLoadSceneOption;
    allowAddAlbum?: boolean;
    albumImageName?: string;
    titles?: EditorChartletItemConfig[];
    lists?: EditorChartletItemConfig[][];
}
export interface EditorChartletItemConfig {
    uri?: string;
}
export interface EditorCropSizeConfig {
    angleScaleColor?: Color;
    isRoundCrop?: boolean;
    isFixedRatio?: boolean;
    aspectRatio?: Size;
    maskType?: EditorMaskTypeConfig;
    isShowScaleSize?: boolean;
    defaultSeletedIndex?: number;
    aspectRatios?: EditorRatioConfig[];
    isResetToOriginal?: boolean;
    maskRowCount?: number;
    maskLandscapeRowNumber?: number;
}
export interface EditorToolOptionConfig {
    type: EditorToolOption;
}
export interface EditorToolsViewConfig {
    toolOptions?: EditorToolOptionConfig[];
    toolSelectedColor?: Color;
    musicTickColor?: Color;
    musicTickBackgroundColor?: Color;
}
export interface EditorConfig {
    modalPresentationStyle?: ModalPresentationStyleOption;
    languageType?: LanguageTypeOption;
    prefersStatusBarHidden?: boolean;
    shouldAutorotate?: boolean;
    isAutoBack?: boolean;
    supportedInterfaceOrientations?: InterfaceOrientationOption[];
    cancelButtonTitleColor?: Color;
    finishButtonTitleNormalColor?: Color;
    finishButtonTitleDisableColor?: Color;
    isWhetherFinishButtonDisabledInUneditedState?: boolean;
    buttonType?: EditorButtonTypeOption;
    urlConfig?: EditorURLConfig;
    photo?: EditorPhotoConfig;
    video?: EditorVideoConfig;
    brush?: EditorBrushConfig;
    chartlet?: EditorChartletConfig;
    text?: EditorTextConfig;
    cropSize?: EditorCropSizeConfig;
    mosaic?: EditorMosaicConfig;
    isFixedCropSizeState?: boolean;
    isIgnoreCropTimeWhenFixedCropSizeState?: boolean;
    toolsView?: EditorToolsViewConfig;
    indicatorType?: IndicatorTypeOption;
}
export interface PickerConfig {
    themeColor?: Color;
    isRemoveSelectedAssetWhenRemovingAssets?: boolean;
    modalPresentationStyle?: ModalPresentationStyleOption;
    pickerPresentStyle?: PickerPresentStyleConfig;
    languageType?: LanguageTypeOption;
    appearanceStyle?: AppearanceStyleOption;
    prefersStatusBarHidden?: boolean;
    shouldAutorotate?: boolean;
    supportedInterfaceOrientations?: InterfaceOrientationOption[];
    isAutoBack?: boolean;
    isSelectedOriginal?: boolean;
    selectOptions?: PickerAssetOption[];
    selectMode?: PickerSelectModeOption;
    isDisableHDR?: boolean;
    isDisableLivePhoto?: boolean;
    isLivePhotoMuted?: boolean;
    allowSelectedTogether?: boolean;
    allowLoadPhotoLibrary?: boolean;
    allowSyncICloudWhenSelectPhoto?: boolean;
    albumShowMode?: AlbumShowModeConfig;
    creationDate?: boolean;
    photoSelectionTapAction?: SelectionTapActionOption;
    videoSelectionTapAction?: SelectionTapActionOption;
    maximumSelectedPhotoCount?: number;
    maximumSelectedVideoCount?: number;
    maximumSelectedCount?: number;
    maximumSelectedVideoDuration?: number;
    minimumSelectedVideoDuration?: number;
    maximumSelectedVideoFileSize?: number;
    maximumSelectedPhotoFileSize?: number;
    editorOptions?: PickerAssetOption[];
    maximumVideoEditDuration?: number;
    isDeselectPhotoRemoveEdited?: boolean;
    isDeselectVideoRemoveEdited?: boolean;
    editorJumpStyle?: EditorJumpStyleConfig;
    editor?: EditorConfig;
    allowCustomTransitionAnimation?: boolean;
    statusBarStyle?: StatusBarStyleOption;
    navigationBarIsTranslucent?: boolean;
    navigationViewBackgroundColor?: Color;
    navigationViewBackgroudDarkColor?: Color;
    navigationBarStyle?: BarStyleOption;
    navigationBarDarkStyle?: BarStyleOption;
    adaptiveBarAppearance?: boolean;
    navigationTitleColor?: Color;
    navigationTitleDarkColor?: Color;
    navigationTintColor?: Color;
    navigationDarkTintColor?: Color;
    navigationBackgroundColor?: Color;
    navigationBackgroundDarkColor?: Color;
    albumController?: PhotoAlbumControllerConfig;
    albumList?: AlbumListConfig;
    emptyAlbumName?: string;
    emptyCoverImageName?: string;
    photoList?: PhotoListConfig;
    previewView?: PreviewViewConfig;
    notAuthorized?: NotAuthorizedConfig;
    isCacheCameraAlbum?: boolean;
    splitSeparatorLineColor?: Color;
    splitSeparatorLineDarkColor?: Color;
    isFetchDeatilsAsset?: boolean;
    indicatorType?: IndicatorTypeOption;
    isDebugLogsEnabled?: boolean;
}
export interface PickerPhotoAsset {
    localIdentifier: string;
}
export interface PickerResult {
    isOriginal: boolean;
    photoAssets: PickerPhotoAsset[];
}
export interface HXPhotoPicker extends HybridObject<{
    ios: 'swift';
}> {
    picker(config: PickerConfig, complete: (result: PickerResult) => void, cancel: () => void): void;
}
//# sourceMappingURL=HXPhotoPicker.nitro.d.ts.map