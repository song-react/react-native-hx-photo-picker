import AVFoundation
import Foundation
import HXPhotoPicker
import MobileCoreServices
import UIKit

public final class HXPhotoPickerImpl: HybridHXPhotoPickerSpec {
  public override init() {
    super.init()
  }

  public func picker(
    config: PickerConfig,
    complete: @escaping (PickerResult) -> Void,
    cancel: @escaping () -> Void
  ) throws {
    DispatchQueue.main.async {
      var pickerConfig = PickerConfiguration()
      self.applyPickerConfig(config, to: &pickerConfig)

      Photo.picker(pickerConfig) { result, _ in
        let payload = self.mapPickerResult(result)
        complete(payload)
      } cancel: { _ in
        cancel()
      }
    }
  }

  private func mapPickerResult(
    _ result: HXPhotoPicker.PickerResult
  ) -> PickerResult {
    let assets = result.photoAssets.map { asset in
      PickerPhotoAsset(
        localIdentifier: asset.identifier
      )
    }
    return PickerResult(isOriginal: result.isOriginal, photoAssets: assets)
  }
}

private extension HXPhotoPickerImpl {
  func applyPickerConfig(
    _ config: PickerConfig,
    to pickerConfig: inout PickerConfiguration
  ) {
    if let themeColor = config.themeColor,
       let color = parseColor(themeColor) {
      pickerConfig.themeColor = color
    }
    if let isRemoveSelectedAssetWhenRemovingAssets =
      config.isRemoveSelectedAssetWhenRemovingAssets {
      pickerConfig.isRemoveSelectedAssetWhenRemovingAssets =
        isRemoveSelectedAssetWhenRemovingAssets
    }
    if let modalPresentationStyle = config.modalPresentationStyle {
      pickerConfig.modalPresentationStyle =
        mapModalPresentationStyle(modalPresentationStyle)
    }
    if let pickerPresentStyle = config.pickerPresentStyle,
       pickerPresentStyle.type != nil ||
        pickerPresentStyle.rightSwipeTriggerRange != nil {
      pickerConfig.pickerPresentStyle = mapPickerPresentStyle(pickerPresentStyle)
    }
    if let languageType = config.languageType {
      pickerConfig.languageType = mapLanguageType(languageType)
    }
    if let appearanceStyle = config.appearanceStyle {
      pickerConfig.appearanceStyle = mapAppearanceStyle(appearanceStyle)
    }
    if let prefersStatusBarHidden = config.prefersStatusBarHidden {
      pickerConfig.prefersStatusBarHidden = prefersStatusBarHidden
    }
    if let shouldAutorotate = config.shouldAutorotate {
      pickerConfig.shouldAutorotate = shouldAutorotate
    }
    if let supportedInterfaceOrientations = config.supportedInterfaceOrientations {
      pickerConfig.supportedInterfaceOrientations =
        mapInterfaceOrientations(supportedInterfaceOrientations)
    }
    if let isAutoBack = config.isAutoBack {
      pickerConfig.isAutoBack = isAutoBack
    }
    if let isSelectedOriginal = config.isSelectedOriginal {
      pickerConfig.isSelectedOriginal = isSelectedOriginal
    }
    if let selectOptions = config.selectOptions {
      pickerConfig.selectOptions = mapPickerAssetOptions(selectOptions)
    }
    if let selectMode = config.selectMode {
      pickerConfig.selectMode = mapPickerSelectMode(selectMode)
    }
    if let isDisableHDR = config.isDisableHDR {
      pickerConfig.isDisableHDR = isDisableHDR
    }
    if let isDisableLivePhoto = config.isDisableLivePhoto {
      pickerConfig.isDisableLivePhoto = isDisableLivePhoto
    }
    if let isLivePhotoMuted = config.isLivePhotoMuted {
      pickerConfig.isLivePhotoMuted = isLivePhotoMuted
    }
    if let allowSelectedTogether = config.allowSelectedTogether {
      pickerConfig.allowSelectedTogether = allowSelectedTogether
    }
    if let allowLoadPhotoLibrary = config.allowLoadPhotoLibrary {
      pickerConfig.allowLoadPhotoLibrary = allowLoadPhotoLibrary
    }
    if let allowSyncICloudWhenSelectPhoto =
      config.allowSyncICloudWhenSelectPhoto {
      pickerConfig.allowSyncICloudWhenSelectPhoto =
        allowSyncICloudWhenSelectPhoto
    }
    if let albumShowMode = config.albumShowMode, albumShowMode.type != nil {
      pickerConfig.albumShowMode = mapAlbumShowMode(albumShowMode)
    }
    if let creationDate = config.creationDate {
      pickerConfig.creationDate = creationDate
    }
    if let photoSelectionTapAction = config.photoSelectionTapAction {
      pickerConfig.photoSelectionTapAction =
        mapSelectionTapAction(photoSelectionTapAction)
    }
    if let videoSelectionTapAction = config.videoSelectionTapAction {
      pickerConfig.videoSelectionTapAction =
        mapSelectionTapAction(videoSelectionTapAction)
    }
    if let maximumSelectedPhotoCount = config.maximumSelectedPhotoCount {
      pickerConfig.maximumSelectedPhotoCount =
        Int(maximumSelectedPhotoCount)
    }
    if let maximumSelectedVideoCount = config.maximumSelectedVideoCount {
      pickerConfig.maximumSelectedVideoCount =
        Int(maximumSelectedVideoCount)
    }
    if let maximumSelectedCount = config.maximumSelectedCount {
      pickerConfig.maximumSelectedCount = Int(maximumSelectedCount)
    }
    if let maximumSelectedVideoDuration = config.maximumSelectedVideoDuration {
      pickerConfig.maximumSelectedVideoDuration =
        Int(maximumSelectedVideoDuration)
    }
    if let minimumSelectedVideoDuration = config.minimumSelectedVideoDuration {
      pickerConfig.minimumSelectedVideoDuration =
        Int(minimumSelectedVideoDuration)
    }
    if let maximumSelectedVideoFileSize = config.maximumSelectedVideoFileSize {
      pickerConfig.maximumSelectedVideoFileSize =
        Int(maximumSelectedVideoFileSize)
    }
    if let maximumSelectedPhotoFileSize = config.maximumSelectedPhotoFileSize {
      pickerConfig.maximumSelectedPhotoFileSize =
        Int(maximumSelectedPhotoFileSize)
    }

    #if HXPICKER_ENABLE_EDITOR
    if let editorOptions = config.editorOptions {
      pickerConfig.editorOptions = mapPickerAssetOptions(editorOptions)
    }
    if let maximumVideoEditDuration = config.maximumVideoEditDuration {
      pickerConfig.maximumVideoEditDuration = Int(maximumVideoEditDuration)
    }
    if let isDeselectPhotoRemoveEdited = config.isDeselectPhotoRemoveEdited {
      pickerConfig.isDeselectPhotoRemoveEdited =
        isDeselectPhotoRemoveEdited
    }
    if let isDeselectVideoRemoveEdited = config.isDeselectVideoRemoveEdited {
      pickerConfig.isDeselectVideoRemoveEdited =
        isDeselectVideoRemoveEdited
    }
    if let editorJumpStyle = config.editorJumpStyle {
      pickerConfig.editorJumpStyle = mapEditorJumpStyle(editorJumpStyle)
    }
    if let editor = config.editor {
      applyEditorConfig(editor, to: &pickerConfig.editor)
    }
    #endif

    if let allowCustomTransitionAnimation =
      config.allowCustomTransitionAnimation {
      pickerConfig.allowCustomTransitionAnimation = allowCustomTransitionAnimation
    }
    if let statusBarStyle = config.statusBarStyle {
      pickerConfig.statusBarStyle = mapStatusBarStyle(statusBarStyle)
    }
    if let navigationBarIsTranslucent = config.navigationBarIsTranslucent {
      pickerConfig.navigationBarIsTranslucent = navigationBarIsTranslucent
    }
    if let navigationViewBackgroundColor =
      config.navigationViewBackgroundColor,
      let color = parseColor(navigationViewBackgroundColor) {
      pickerConfig.navigationViewBackgroundColor = color
    }
    if let navigationViewBackgroudDarkColor =
      config.navigationViewBackgroudDarkColor,
      let color = parseColor(navigationViewBackgroudDarkColor) {
      pickerConfig.navigationViewBackgroudDarkColor = color
    }
    if let navigationBarStyle = config.navigationBarStyle {
      pickerConfig.navigationBarStyle = mapBarStyle(navigationBarStyle)
    }
    if let navigationBarDarkStyle = config.navigationBarDarkStyle {
      pickerConfig.navigationBarDarkStyle = mapBarStyle(navigationBarDarkStyle)
    }
    if let adaptiveBarAppearance = config.adaptiveBarAppearance {
      pickerConfig.adaptiveBarAppearance = adaptiveBarAppearance
    }
    if let navigationTitleColor = config.navigationTitleColor,
      let color = parseColor(navigationTitleColor) {
      pickerConfig.navigationTitleColor = color
    }
    if let navigationTitleDarkColor = config.navigationTitleDarkColor,
      let color = parseColor(navigationTitleDarkColor) {
      pickerConfig.navigationTitleDarkColor = color
    }
    if let navigationTintColor = config.navigationTintColor,
      let color = parseColor(navigationTintColor) {
      pickerConfig.navigationTintColor = color
    }
    if let navigationDarkTintColor = config.navigationDarkTintColor,
      let color = parseColor(navigationDarkTintColor) {
      pickerConfig.navigationDarkTintColor = color
    }
    if let navigationBackgroundColor = config.navigationBackgroundColor,
      let color = parseColor(navigationBackgroundColor) {
      pickerConfig.navigationBackgroundColor = color
    }
    if let navigationBackgroundDarkColor = config.navigationBackgroundDarkColor,
      let color = parseColor(navigationBackgroundDarkColor) {
      pickerConfig.navigationBackgroundDarkColor = color
    }

    if let albumController = config.albumController {
      applyPhotoAlbumControllerConfig(
        albumController,
        to: &pickerConfig.albumController
      )
    }
    if let albumList = config.albumList {
      applyAlbumListConfig(albumList, to: &pickerConfig.albumList)
    }
    if let emptyAlbumName = config.emptyAlbumName {
      pickerConfig.emptyAlbumName = emptyAlbumName
    }
    if let emptyCoverImageName = config.emptyCoverImageName {
      pickerConfig.emptyCoverImageName = emptyCoverImageName
    }
    if let photoList = config.photoList {
      applyPhotoListConfig(photoList, to: &pickerConfig.photoList)
    }
    if let previewView = config.previewView {
      applyPreviewViewConfig(previewView, to: &pickerConfig.previewView)
    }
    if let notAuthorized = config.notAuthorized {
      applyNotAuthorizedConfig(notAuthorized, to: &pickerConfig.notAuthorized)
    }
    if let isCacheCameraAlbum = config.isCacheCameraAlbum {
      pickerConfig.isCacheCameraAlbum = isCacheCameraAlbum
    }
    if let splitSeparatorLineColor = config.splitSeparatorLineColor,
      let color = parseColor(splitSeparatorLineColor) {
      pickerConfig.splitSeparatorLineColor = color
    }
    if let splitSeparatorLineDarkColor = config.splitSeparatorLineDarkColor,
      let color = parseColor(splitSeparatorLineDarkColor) {
      pickerConfig.splitSeparatorLineDarkColor = color
    }
    if let isFetchDeatilsAsset = config.isFetchDeatilsAsset {
      pickerConfig.isFetchDeatilsAsset = isFetchDeatilsAsset
    }
    if let indicatorType = config.indicatorType {
      pickerConfig.indicatorType = mapIndicatorType(indicatorType)
    }
    if let isDebugLogsEnabled = config.isDebugLogsEnabled {
      pickerConfig.isDebugLogsEnabled = isDebugLogsEnabled
    }
  }

  func applyAlbumListConfig(
    _ config: AlbumListConfig,
    to albumList: inout AlbumListConfiguration
  ) {
    if let limitedStatusPromptColor = config.limitedStatusPromptColor,
      let color = parseColor(limitedStatusPromptColor) {
      albumList.limitedStatusPromptColor = color
    }
    if let limitedStatusPromptDarkColor = config.limitedStatusPromptDarkColor,
      let color = parseColor(limitedStatusPromptDarkColor) {
      albumList.limitedStatusPromptDarkColor = color
    }
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      albumList.backgroundColor = color
    }
    if let backgroundDarkColor = config.backgroundDarkColor,
      let color = parseColor(backgroundDarkColor) {
      albumList.backgroundDarkColor = color
    }
    if let splitBackgroundColor = config.splitBackgroundColor,
      let color = parseColor(splitBackgroundColor) {
      albumList.splitBackgroundColor = color
    }
    if let splitBackgroundDarkColor = config.splitBackgroundDarkColor,
      let color = parseColor(splitBackgroundDarkColor) {
      albumList.splitBackgroundDarkColor = color
    }
    if let cellHeight = config.cellHeight {
      albumList.cellHeight = CGFloat(cellHeight)
    }
    if let splitCellHeight = config.splitCellHeight {
      albumList.splitCellHeight = CGFloat(splitCellHeight)
    }
    if let cellBackgroundColor = config.cellBackgroundColor,
      let color = parseColor(cellBackgroundColor) {
      albumList.cellBackgroundColor = color
    }
    if let cellBackgroundDarkColor = config.cellBackgroundDarkColor,
      let color = parseColor(cellBackgroundDarkColor) {
      albumList.cellBackgroundDarkColor = color
    }
    if let cellSelectedColor = config.cellSelectedColor,
      let color = parseColor(cellSelectedColor) {
      albumList.cellSelectedColor = color
    }
    if let cellSelectedDarkColor = config.cellSelectedDarkColor,
      let color = parseColor(cellSelectedDarkColor) {
      albumList.cellSelectedDarkColor = color
    }
    if let albumNameColor = config.albumNameColor,
      let color = parseColor(albumNameColor) {
      albumList.albumNameColor = color
    }
    if let albumNameDarkColor = config.albumNameDarkColor,
      let color = parseColor(albumNameDarkColor) {
      albumList.albumNameDarkColor = color
    }
    if let albumNameFont = config.albumNameFont,
      let font = parseFont(albumNameFont) {
      albumList.albumNameFont = font
    }
    if let photoCountColor = config.photoCountColor,
      let color = parseColor(photoCountColor) {
      albumList.photoCountColor = color
    }
    if let photoCountDarkColor = config.photoCountDarkColor,
      let color = parseColor(photoCountDarkColor) {
      albumList.photoCountDarkColor = color
    }
    if let isShowPhotoCount = config.isShowPhotoCount {
      albumList.isShowPhotoCount = isShowPhotoCount
    }
    if let photoCountFont = config.photoCountFont,
      let font = parseFont(photoCountFont) {
      albumList.photoCountFont = font
    }
    if let separatorLineColor = config.separatorLineColor,
      let color = parseColor(separatorLineColor) {
      albumList.separatorLineColor = color
    }
    if let separatorLineDarkColor = config.separatorLineDarkColor,
      let color = parseColor(separatorLineDarkColor) {
      albumList.separatorLineDarkColor = color
    }
    if let tickColor = config.tickColor,
      let color = parseColor(tickColor) {
      albumList.tickColor = color
    }
    if let tickDarkColor = config.tickDarkColor,
      let color = parseColor(tickDarkColor) {
      albumList.tickDarkColor = color
    }
  }

  func applyAlbumTitleViewConfig(
    _ config: AlbumTitleViewConfig,
    to titleView: inout AlbumTitleViewConfiguration
  ) {
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      titleView.backgroundColor = color
    }
    if let backgroudDarkColor = config.backgroudDarkColor,
      let color = parseColor(backgroudDarkColor) {
      titleView.backgroudDarkColor = color
    }
    if let arrow = config.arrow {
      applyArrowViewConfig(arrow, to: &titleView.arrow)
    }
  }

  func applyArrowViewConfig(
    _ config: ArrowViewConfig,
    to arrowView: inout ArrowViewConfiguration
  ) {
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      arrowView.backgroundColor = color
    }
    if let arrowColor = config.arrowColor,
      let color = parseColor(arrowColor) {
      arrowView.arrowColor = color
    }
    if let backgroudDarkColor = config.backgroudDarkColor,
      let color = parseColor(backgroudDarkColor) {
      arrowView.backgroudDarkColor = color
    }
    if let arrowDarkColor = config.arrowDarkColor,
      let color = parseColor(arrowDarkColor) {
      arrowView.arrowDarkColor = color
    }
  }

  func applyPhotoAlbumControllerConfig(
    _ config: PhotoAlbumControllerConfig,
    to albumController: inout PhotoAlbumControllerConfiguration
  ) {
    if let limitedStatusPromptColor = config.limitedStatusPromptColor,
      let color = parseColor(limitedStatusPromptColor) {
      albumController.limitedStatusPromptColor = color
    }
    if let limitedStatusPromptDarkColor =
      config.limitedStatusPromptDarkColor,
      let color = parseColor(limitedStatusPromptDarkColor) {
      albumController.limitedStatusPromptDarkColor = color
    }
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      albumController.backgroundColor = color
    }
    if let backgroundDarkColor = config.backgroundDarkColor,
      let color = parseColor(backgroundDarkColor) {
      albumController.backgroundDarkColor = color
    }
    if let cellBackgroundColor = config.cellBackgroundColor,
      let color = parseColor(cellBackgroundColor) {
      albumController.cellBackgroundColor = color
    }
    if let cellBackgroundDarkColor = config.cellBackgroundDarkColor,
      let color = parseColor(cellBackgroundDarkColor) {
      albumController.cellBackgroundDarkColor = color
    }
    if let cellSelectedColor = config.cellSelectedColor,
      let color = parseColor(cellSelectedColor) {
      albumController.cellSelectedColor = color
    }
    if let cellSelectedDarkColor = config.cellSelectedDarkColor,
      let color = parseColor(cellSelectedDarkColor) {
      albumController.cellSelectedDarkColor = color
    }
    if let headerTitleColor = config.headerTitleColor,
      let color = parseColor(headerTitleColor) {
      albumController.headerTitleColor = color
    }
    if let headerTitleDarkColor = config.headerTitleDarkColor,
      let color = parseColor(headerTitleDarkColor) {
      albumController.headerTitleDarkColor = color
    }
    if let headerTitleFont = config.headerTitleFont,
      let font = parseFont(headerTitleFont) {
      albumController.headerTitleFont = font
    }
    if let headerButtonTitleColor = config.headerButtonTitleColor,
      let color = parseColor(headerButtonTitleColor) {
      albumController.headerButtonTitleColor = color
    }
    if let headerButtonTitleDarkColor = config.headerButtonTitleDarkColor,
      let color = parseColor(headerButtonTitleDarkColor) {
      albumController.headerButtonTitleDarkColor = color
    }
    if let headerButtonTitleFont = config.headerButtonTitleFont,
      let font = parseFont(headerButtonTitleFont) {
      albumController.headerButtonTitleFont = font
    }
    if let albumNameColor = config.albumNameColor,
      let color = parseColor(albumNameColor) {
      albumController.albumNameColor = color
    }
    if let albumNameDarkColor = config.albumNameDarkColor,
      let color = parseColor(albumNameDarkColor) {
      albumController.albumNameDarkColor = color
    }
    if let albumNameFont = config.albumNameFont,
      let font = parseFont(albumNameFont) {
      albumController.albumNameFont = font
    }
    if let photoCountColor = config.photoCountColor,
      let color = parseColor(photoCountColor) {
      albumController.photoCountColor = color
    }
    if let photoCountDarkColor = config.photoCountDarkColor,
      let color = parseColor(photoCountDarkColor) {
      albumController.photoCountDarkColor = color
    }
    if let isShowPhotoCount = config.isShowPhotoCount {
      albumController.isShowPhotoCount = isShowPhotoCount
    }
    if let photoCountFont = config.photoCountFont,
      let font = parseFont(photoCountFont) {
      albumController.photoCountFont = font
    }
    if let separatorLineColor = config.separatorLineColor,
      let color = parseColor(separatorLineColor) {
      albumController.separatorLineColor = color
    }
    if let separatorLineDarkColor = config.separatorLineDarkColor,
      let color = parseColor(separatorLineDarkColor) {
      albumController.separatorLineDarkColor = color
    }
    if let imageColor = config.imageColor,
      let color = parseColor(imageColor) {
      albumController.imageColor = color
    }
    if let imageDarkColor = config.imageDarkColor,
      let color = parseColor(imageDarkColor) {
      albumController.imageDarkColor = color
    }
    if let mediaTitleColor = config.mediaTitleColor,
      let color = parseColor(mediaTitleColor) {
      albumController.mediaTitleColor = color
    }
    if let mediaTitleDarkColor = config.mediaTitleDarkColor,
      let color = parseColor(mediaTitleDarkColor) {
      albumController.mediaTitleDarkColor = color
    }
    if let mediaTitleFont = config.mediaTitleFont,
      let font = parseFont(mediaTitleFont) {
      albumController.mediaTitleFont = font
    }
    if let mediaCountColor = config.mediaCountColor,
      let color = parseColor(mediaCountColor) {
      albumController.mediaCountColor = color
    }
    if let mediaCountDarkColor = config.mediaCountDarkColor,
      let color = parseColor(mediaCountDarkColor) {
      albumController.mediaCountDarkColor = color
    }
    if let mediaCountFont = config.mediaCountFont,
      let font = parseFont(mediaCountFont) {
      albumController.mediaCountFont = font
    }
    if let arrowColor = config.arrowColor,
      let color = parseColor(arrowColor) {
      albumController.arrowColor = color
    }
    if let arrowDarkColor = config.arrowDarkColor,
      let color = parseColor(arrowDarkColor) {
      albumController.arrowDarkColor = color
    }
  }

  func applyNotAuthorizedConfig(
    _ config: NotAuthorizedConfig,
    to notAuthorized: inout NotAuthorizedConfiguration
  ) {
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      notAuthorized.backgroundColor = color
    }
    if let darkBackgroundColor = config.darkBackgroundColor,
      let color = parseColor(darkBackgroundColor) {
      notAuthorized.darkBackgroundColor = color
    }
    if let closeButtonImageName = config.closeButtonImageName {
      notAuthorized.closeButtonImageName = closeButtonImageName
    }
    if let closeButtonDarkImageName = config.closeButtonDarkImageName {
      notAuthorized.closeButtonDarkImageName = closeButtonDarkImageName
    }
    if let closeButtonColor = config.closeButtonColor,
      let color = parseColor(closeButtonColor) {
      notAuthorized.closeButtonColor = color
    }
    if let closeButtonDarkColor = config.closeButtonDarkColor,
      let color = parseColor(closeButtonDarkColor) {
      notAuthorized.closeButtonDarkColor = color
    }
    if let isHiddenCloseButton = config.isHiddenCloseButton {
      notAuthorized.isHiddenCloseButton = isHiddenCloseButton
    }
    if let titleColor = config.titleColor,
      let color = parseColor(titleColor) {
      notAuthorized.titleColor = color
    }
    if let titleDarkColor = config.titleDarkColor,
      let color = parseColor(titleDarkColor) {
      notAuthorized.titleDarkColor = color
    }
    if let subTitleColor = config.subTitleColor,
      let color = parseColor(subTitleColor) {
      notAuthorized.subTitleColor = color
    }
    if let darkSubTitleColor = config.darkSubTitleColor,
      let color = parseColor(darkSubTitleColor) {
      notAuthorized.darkSubTitleColor = color
    }
    if let jumpButtonBackgroundColor = config.jumpButtonBackgroundColor,
      let color = parseColor(jumpButtonBackgroundColor) {
      notAuthorized.jumpButtonBackgroundColor = color
    }
    if let jumpButtonDarkBackgroundColor =
      config.jumpButtonDarkBackgroundColor,
      let color = parseColor(jumpButtonDarkBackgroundColor) {
      notAuthorized.jumpButtonDarkBackgroundColor = color
    }
    if let jumpButtonTitleColor = config.jumpButtonTitleColor,
      let color = parseColor(jumpButtonTitleColor) {
      notAuthorized.jumpButtonTitleColor = color
    }
    if let jumpButtonTitleDarkColor = config.jumpButtonTitleDarkColor,
      let color = parseColor(jumpButtonTitleDarkColor) {
      notAuthorized.jumpButtonTitleDarkColor = color
    }
  }

  func applyPhotoListConfig(
    _ config: PhotoListConfig,
    to photoList: inout PhotoListConfiguration
  ) {
    if let titleView = config.titleView {
      applyAlbumTitleViewConfig(titleView, to: &photoList.titleView)
    }
    if let sort = config.sort {
      photoList.sort = mapSort(sort)
    }
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      photoList.backgroundColor = color
    }
    if let backgroundDarkColor = config.backgroundDarkColor,
      let color = parseColor(backgroundDarkColor) {
      photoList.backgroundDarkColor = color
    }
    if let cancelImageName = config.cancelImageName {
      photoList.cancelImageName = cancelImageName
    }
    if let cancelDarkImageName = config.cancelDarkImageName {
      photoList.cancelDarkImageName = cancelDarkImageName
    }
    if let isShowFilterItem = config.isShowFilterItem {
      photoList.isShowFilterItem = isShowFilterItem
    }
    if let filterThemeColor = config.filterThemeColor,
      let color = parseColor(filterThemeColor) {
      photoList.filterThemeColor = color
    }
    if let filterThemeDarkColor = config.filterThemeDarkColor,
      let color = parseColor(filterThemeDarkColor) {
      photoList.filterThemeDarkColor = color
    }
    if let rowNumber = config.rowNumber {
      photoList.rowNumber = Int(rowNumber)
    }
    if let landscapeRowNumber = config.landscapeRowNumber {
      photoList.landscapeRowNumber = Int(landscapeRowNumber)
    }
    if let spltRowNumber = config.spltRowNumber {
      photoList.spltRowNumber = Int(spltRowNumber)
    }
    if let spacing = config.spacing {
      photoList.spacing = CGFloat(spacing)
    }
    if let allowHapticTouchPreview = config.allowHapticTouchPreview {
      photoList.allowHapticTouchPreview = allowHapticTouchPreview
    }
    if let allowAddMenuElements = config.allowAddMenuElements {
      photoList.allowAddMenuElements = allowAddMenuElements
    }
    if let allowSwipeToSelect = config.allowSwipeToSelect {
      photoList.allowSwipeToSelect = allowSwipeToSelect
    }
    if let swipeSelectAllowAutoScroll = config.swipeSelectAllowAutoScroll {
      photoList.swipeSelectAllowAutoScroll = swipeSelectAllowAutoScroll
    }
    if let swipeSelectIgnoreLeftArea = config.swipeSelectIgnoreLeftArea {
      photoList.swipeSelectIgnoreLeftArea = CGFloat(swipeSelectIgnoreLeftArea)
    }
    if let swipeSelectScrollSpeed = config.swipeSelectScrollSpeed {
      photoList.swipeSelectScrollSpeed = CGFloat(swipeSelectScrollSpeed)
    }
    if let autoSwipeTopAreaHeight = config.autoSwipeTopAreaHeight {
      photoList.autoSwipeTopAreaHeight = CGFloat(autoSwipeTopAreaHeight)
    }
    if let autoSwipeBottomAreaHeight = config.autoSwipeBottomAreaHeight {
      photoList.autoSwipeBottomAreaHeight = CGFloat(autoSwipeBottomAreaHeight)
    }
    if let cell = config.cell {
      applyPhotoListCellConfig(cell, to: &photoList.cell)
    }
    if let bottomView = config.bottomView {
      applyPickerBottomViewConfig(bottomView, to: &photoList.bottomView)
    }
    if let allowAddCamera = config.allowAddCamera {
      photoList.allowAddCamera = allowAddCamera
    }
    if let cameraCell = config.cameraCell {
      applyPhotoListCameraCellConfig(cameraCell, to: &photoList.cameraCell)
    }
    if let finishSelectionAfterTakingPhoto =
      config.finishSelectionAfterTakingPhoto {
      photoList.finishSelectionAfterTakingPhoto = finishSelectionAfterTakingPhoto
    }
    if let cameraType = config.cameraType,
       let cameraTypeValue = mapPhotoListCameraType(cameraType) {
      photoList.cameraType = cameraTypeValue
    }
    if let takePictureCompletionToSelected =
      config.takePictureCompletionToSelected {
      photoList.takePictureCompletionToSelected =
        takePictureCompletionToSelected
    }
    if let isSaveSystemAlbum = config.isSaveSystemAlbum {
      photoList.isSaveSystemAlbum = isSaveSystemAlbum
    }
    if let saveSystemAlbumType = config.saveSystemAlbumType {
      photoList.saveSystemAlbumType = mapSaveSystemAlbumType(saveSystemAlbumType)
    }
    if let allowAddLimit = config.allowAddLimit {
      photoList.allowAddLimit = allowAddLimit
    }
    if let limitCell = config.limitCell {
      applyPhotoListLimitCellConfig(limitCell, to: &photoList.limitCell)
    }
    if let isShowAssetNumber = config.isShowAssetNumber {
      photoList.isShowAssetNumber = isShowAssetNumber
    }
    if let assetNumber = config.assetNumber {
      applyPhotoListAssetNumberConfig(assetNumber, to: &photoList.assetNumber)
    }
    if let emptyView = config.emptyView {
      applyEmptyViewConfig(emptyView, to: &photoList.emptyView)
    }
    if let previewStyle = config.previewStyle {
      photoList.previewStyle = mapPreviewJumpStyle(previewStyle)
    }
    if let selectedAssetIdentifier = config.selectedAssetIdentifier {
      photoList.selectedAssetIdentifier = selectedAssetIdentifier
    }
  }

  func applyPhotoListCellConfig(
    _ config: PhotoListCellConfig,
    to cellConfig: inout PhotoListCellConfiguration
  ) {
    if let isShowICloudMark = config.isShowICloudMark {
      cellConfig.isShowICloudMark = isShowICloudMark
    }
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      cellConfig.backgroundColor = color
    }
    if let backgroundDarkColor = config.backgroundDarkColor,
      let color = parseColor(backgroundDarkColor) {
      cellConfig.backgroundDarkColor = color
    }
    if let targetWidth = config.targetWidth {
      cellConfig.targetWidth = CGFloat(targetWidth)
    }
    if let isShowDisableMask = config.isShowDisableMask {
      cellConfig.isShowDisableMask = isShowDisableMask
    }
    if let isHiddenSingleVideoSelect = config.isHiddenSingleVideoSelect {
      cellConfig.isHiddenSingleVideoSelect = isHiddenSingleVideoSelect
    }
    if let selectBoxTopMargin = config.selectBoxTopMargin {
      cellConfig.selectBoxTopMargin = CGFloat(selectBoxTopMargin)
    }
    if let selectBoxRightMargin = config.selectBoxRightMargin {
      cellConfig.selectBoxRightMargin = CGFloat(selectBoxRightMargin)
    }
    if let selectBox = config.selectBox {
      applySelectBoxConfig(selectBox, to: &cellConfig.selectBox)
    }
    if let isShowLivePhotoControl = config.isShowLivePhotoControl {
      cellConfig.isShowLivePhotoControl = isShowLivePhotoControl
    }
    if let isPlayLivePhoto = config.isPlayLivePhoto {
      cellConfig.isPlayLivePhoto = isPlayLivePhoto
    }
    if let indicatorColor = config.kf_indicatorColor,
      let color = parseColor(indicatorColor) {
      cellConfig.kf_indicatorColor = color
    }
  }

  func applyPhotoListCameraCellConfig(
    _ config: PhotoListCameraCellConfig,
    to cellConfig: inout PhotoListConfiguration.CameraCell
  ) {
    if let allowPreview = config.allowPreview {
      cellConfig.allowPreview = allowPreview
    }
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      cellConfig.backgroundColor = color
    }
    if let backgroundDarkColor = config.backgroundDarkColor,
      let color = parseColor(backgroundDarkColor) {
      cellConfig.backgroundDarkColor = color
    }
    if let cameraImageName = config.cameraImageName {
      cellConfig.cameraImageName = cameraImageName
    }
    if let cameraDarkImageName = config.cameraDarkImageName {
      cellConfig.cameraDarkImageName = cameraDarkImageName
    }
  }

  func applyPhotoListLimitCellConfig(
    _ config: PhotoListLimitCellConfig,
    to limitCell: inout PhotoListConfiguration.LimitCell
  ) {
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      limitCell.backgroundColor = color
    }
    if let backgroundDarkColor = config.backgroundDarkColor,
      let color = parseColor(backgroundDarkColor) {
      limitCell.backgroundDarkColor = color
    }
    if let lineColor = config.lineColor,
      let color = parseColor(lineColor) {
      limitCell.lineColor = color
    }
    if let lineDarkColor = config.lineDarkColor,
      let color = parseColor(lineDarkColor) {
      limitCell.lineDarkColor = color
    }
    if let lineWidth = config.lineWidth {
      limitCell.lineWidth = CGFloat(lineWidth)
    }
    if let lineLength = config.lineLength {
      limitCell.lineLength = CGFloat(lineLength)
    }
    if let title = config.title {
      limitCell.title = title
    }
    if let titleColor = config.titleColor,
      let color = parseColor(titleColor) {
      limitCell.titleColor = color
    }
    if let titleDarkColor = config.titleDarkColor,
      let color = parseColor(titleDarkColor) {
      limitCell.titleDarkColor = color
    }
    if let titleFont = config.titleFont,
      let font = parseFont(titleFont) {
      limitCell.titleFont = font
    }
  }

  func applyPhotoListAssetNumberConfig(
    _ config: PhotoListAssetNumberConfig,
    to assetNumber: inout PhotoListConfiguration.AssetNumber
  ) {
    if let textColor = config.textColor,
      let color = parseColor(textColor) {
      assetNumber.textColor = color
    }
    if let textDarkColor = config.textDarkColor,
      let color = parseColor(textDarkColor) {
      assetNumber.textDarkColor = color
    }
    if let textFont = config.textFont,
      let font = parseFont(textFont) {
      assetNumber.textFont = font
    }
    if let filterTitleColor = config.filterTitleColor,
      let color = parseColor(filterTitleColor) {
      assetNumber.filterTitleColor = color
    }
    if let filterTitleDarkColor = config.filterTitleDarkColor,
      let color = parseColor(filterTitleDarkColor) {
      assetNumber.filterTitleDarkColor = color
    }
    if let filterContentColor = config.filterContentColor,
      let color = parseColor(filterContentColor) {
      assetNumber.filterContentColor = color
    }
    if let filterContentDarkColor = config.filterContentDarkColor,
      let color = parseColor(filterContentDarkColor) {
      assetNumber.filterContentDarkColor = color
    }
    if let filterFont = config.filterFont,
      let font = parseFont(filterFont) {
      assetNumber.filterFont = font
    }
  }

  func applyEmptyViewConfig(
    _ config: EmptyViewConfig,
    to emptyView: inout EmptyViewConfiguration
  ) {
    if let titleColor = config.titleColor,
      let color = parseColor(titleColor) {
      emptyView.titleColor = color
    }
    if let titleDarkColor = config.titleDarkColor,
      let color = parseColor(titleDarkColor) {
      emptyView.titleDarkColor = color
    }
    if let subTitleColor = config.subTitleColor,
      let color = parseColor(subTitleColor) {
      emptyView.subTitleColor = color
    }
    if let subTitleDarkColor = config.subTitleDarkColor,
      let color = parseColor(subTitleDarkColor) {
      emptyView.subTitleDarkColor = color
    }
  }

  func applySelectBoxConfig(
    _ config: SelectBoxConfig,
    to selectBox: inout SelectBoxConfiguration
  ) {
    if let size = config.size {
      selectBox.size = toCGSize(size)
    }
    if let style = config.style {
      selectBox.style = mapSelectBoxStyle(style)
    }
    if let titleFontSize = config.titleFontSize {
      selectBox.titleFontSize = CGFloat(titleFontSize)
    }
    if let titleColor = config.titleColor,
      let color = parseColor(titleColor) {
      selectBox.titleColor = color
    }
    if let titleDarkColor = config.titleDarkColor,
      let color = parseColor(titleDarkColor) {
      selectBox.titleDarkColor = color
    }
    if let tickWidth = config.tickWidth {
      selectBox.tickWidth = CGFloat(tickWidth)
    }
    if let tickColor = config.tickColor,
      let color = parseColor(tickColor) {
      selectBox.tickColor = color
    }
    if let tickDarkColor = config.tickDarkColor,
      let color = parseColor(tickDarkColor) {
      selectBox.tickDarkColor = color
    }
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      selectBox.backgroundColor = color
    }
    if let darkBackgroundColor = config.darkBackgroundColor,
      let color = parseColor(darkBackgroundColor) {
      selectBox.darkBackgroundColor = color
    }
    if let selectedBackgroundColor = config.selectedBackgroundColor,
      let color = parseColor(selectedBackgroundColor) {
      selectBox.selectedBackgroundColor = color
    }
    if let selectedBackgroudDarkColor = config.selectedBackgroudDarkColor,
      let color = parseColor(selectedBackgroudDarkColor) {
      selectBox.selectedBackgroudDarkColor = color
    }
    if let borderWidth = config.borderWidth {
      selectBox.borderWidth = CGFloat(borderWidth)
    }
    if let borderColor = config.borderColor,
      let color = parseColor(borderColor) {
      selectBox.borderColor = color
    }
    if let borderDarkColor = config.borderDarkColor,
      let color = parseColor(borderDarkColor) {
      selectBox.borderDarkColor = color
    }
  }

  func applyPickerBottomViewConfig(
    _ config: PickerBottomViewConfig,
    to bottomView: inout PickerBottomViewConfiguration
  ) {
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      bottomView.backgroundColor = color
    }
    if let backgroundDarkColor = config.backgroundDarkColor,
      let color = parseColor(backgroundDarkColor) {
      bottomView.backgroundDarkColor = color
    }
    if let barTintColor = config.barTintColor,
      let color = parseColor(barTintColor) {
      bottomView.barTintColor = color
    }
    if let barTintDarkColor = config.barTintDarkColor,
      let color = parseColor(barTintDarkColor) {
      bottomView.barTintDarkColor = color
    }
    if let isTranslucent = config.isTranslucent {
      bottomView.isTranslucent = isTranslucent
    }
    if let barStyle = config.barStyle {
      bottomView.barStyle = mapBarStyle(barStyle)
    }
    if let barDarkStyle = config.barDarkStyle {
      bottomView.barDarkStyle = mapBarStyle(barDarkStyle)
    }
    if let isHiddenPreviewButton = config.isHiddenPreviewButton {
      bottomView.isHiddenPreviewButton = isHiddenPreviewButton
    }
    if let previewButtonTitleColor = config.previewButtonTitleColor,
      let color = parseColor(previewButtonTitleColor) {
      bottomView.previewButtonTitleColor = color
    }
    if let previewButtonTitleDarkColor = config.previewButtonTitleDarkColor,
      let color = parseColor(previewButtonTitleDarkColor) {
      bottomView.previewButtonTitleDarkColor = color
    }
    if let previewButtonDisableTitleColor =
      config.previewButtonDisableTitleColor,
      let color = parseColor(previewButtonDisableTitleColor) {
      bottomView.previewButtonDisableTitleColor = color
    }
    if let previewButtonDisableTitleDarkColor =
      config.previewButtonDisableTitleDarkColor,
      let color = parseColor(previewButtonDisableTitleDarkColor) {
      bottomView.previewButtonDisableTitleDarkColor = color
    }
    if let isHiddenOriginalButton = config.isHiddenOriginalButton {
      bottomView.isHiddenOriginalButton = isHiddenOriginalButton
    }
    if let originalButtonTitleColor = config.originalButtonTitleColor,
      let color = parseColor(originalButtonTitleColor) {
      bottomView.originalButtonTitleColor = color
    }
    if let originalButtonTitleDarkColor = config.originalButtonTitleDarkColor,
      let color = parseColor(originalButtonTitleDarkColor) {
      bottomView.originalButtonTitleDarkColor = color
    }
    if let isShowOriginalFileSize = config.isShowOriginalFileSize {
      bottomView.isShowOriginalFileSize = isShowOriginalFileSize
    }
    if let originalLoadingStyle = config.originalLoadingStyle {
      bottomView.originalLoadingStyle = mapActivityIndicatorStyle(
        originalLoadingStyle
      )
    }
    if let originalLoadingDarkStyle = config.originalLoadingDarkStyle {
      bottomView.originalLoadingDarkStyle = mapActivityIndicatorStyle(
        originalLoadingDarkStyle
      )
    }
    if let originalSelectBox = config.originalSelectBox {
      applySelectBoxConfig(originalSelectBox, to: &bottomView.originalSelectBox)
    }
    if let finishButtonTitleColor = config.finishButtonTitleColor,
      let color = parseColor(finishButtonTitleColor) {
      bottomView.finishButtonTitleColor = color
    }
    if let finishButtonTitleDarkColor = config.finishButtonTitleDarkColor,
      let color = parseColor(finishButtonTitleDarkColor) {
      bottomView.finishButtonTitleDarkColor = color
    }
    if let finishButtonDisableTitleColor = config.finishButtonDisableTitleColor,
      let color = parseColor(finishButtonDisableTitleColor) {
      bottomView.finishButtonDisableTitleColor = color
    }
    if let finishButtonDisableTitleDarkColor =
      config.finishButtonDisableTitleDarkColor,
      let color = parseColor(finishButtonDisableTitleDarkColor) {
      bottomView.finishButtonDisableTitleDarkColor = color
    }
    if let finishButtonBackgroundColor = config.finishButtonBackgroundColor,
      let color = parseColor(finishButtonBackgroundColor) {
      bottomView.finishButtonBackgroundColor = color
    }
    if let finishButtonDarkBackgroundColor =
      config.finishButtonDarkBackgroundColor,
      let color = parseColor(finishButtonDarkBackgroundColor) {
      bottomView.finishButtonDarkBackgroundColor = color
    }
    if let finishButtonDisableBackgroundColor =
      config.finishButtonDisableBackgroundColor,
      let color = parseColor(finishButtonDisableBackgroundColor) {
      bottomView.finishButtonDisableBackgroundColor = color
    }
    if let finishButtonDisableDarkBackgroundColor =
      config.finishButtonDisableDarkBackgroundColor,
      let color = parseColor(finishButtonDisableDarkBackgroundColor) {
      bottomView.finishButtonDisableDarkBackgroundColor = color
    }
    if let disableFinishButtonWhenNotSelected =
      config.disableFinishButtonWhenNotSelected {
      bottomView.disableFinishButtonWhenNotSelected =
        disableFinishButtonWhenNotSelected
    }
    #if HXPICKER_ENABLE_EDITOR
    if let isHiddenEditButton = config.isHiddenEditButton {
      bottomView.isHiddenEditButton = isHiddenEditButton
    }
    if let editButtonTitleColor = config.editButtonTitleColor,
      let color = parseColor(editButtonTitleColor) {
      bottomView.editButtonTitleColor = color
    }
    if let editButtonTitleDarkColor = config.editButtonTitleDarkColor,
      let color = parseColor(editButtonTitleDarkColor) {
      bottomView.editButtonTitleDarkColor = color
    }
    if let editButtonDisableTitleColor = config.editButtonDisableTitleColor,
      let color = parseColor(editButtonDisableTitleColor) {
      bottomView.editButtonDisableTitleColor = color
    }
    if let editButtonDisableTitleDarkColor =
      config.editButtonDisableTitleDarkColor,
      let color = parseColor(editButtonDisableTitleDarkColor) {
      bottomView.editButtonDisableTitleDarkColor = color
    }
    #endif
    if let isShowPrompt = config.isShowPrompt {
      bottomView.isShowPrompt = isShowPrompt
    }
    if let promptIconColor = config.promptIconColor,
      let color = parseColor(promptIconColor) {
      bottomView.promptIconColor = color
    }
    if let promptIconDarkColor = config.promptIconDarkColor,
      let color = parseColor(promptIconDarkColor) {
      bottomView.promptIconDarkColor = color
    }
    if let promptTitleColor = config.promptTitleColor,
      let color = parseColor(promptTitleColor) {
      bottomView.promptTitleColor = color
    }
    if let promptTitleDarkColor = config.promptTitleDarkColor,
      let color = parseColor(promptTitleDarkColor) {
      bottomView.promptTitleDarkColor = color
    }
    if let promptArrowColor = config.promptArrowColor,
      let color = parseColor(promptArrowColor) {
      bottomView.promptArrowColor = color
    }
    if let promptArrowDarkColor = config.promptArrowDarkColor,
      let color = parseColor(promptArrowDarkColor) {
      bottomView.promptArrowDarkColor = color
    }
    if let isShowPreviewList = config.isShowPreviewList {
      bottomView.isShowPreviewList = isShowPreviewList
    }
    if let previewListTickColor = config.previewListTickColor,
      let color = parseColor(previewListTickColor) {
      bottomView.previewListTickColor = color
    }
    if let previewListTickBgColor = config.previewListTickBgColor,
      let color = parseColor(previewListTickBgColor) {
      bottomView.previewListTickBgColor = color
    }
    if let previewListTickDarkColor = config.previewListTickDarkColor,
      let color = parseColor(previewListTickDarkColor) {
      bottomView.previewListTickDarkColor = color
    }
    if let previewListTickBgDarkColor = config.previewListTickBgDarkColor,
      let color = parseColor(previewListTickBgDarkColor) {
      bottomView.previewListTickBgDarkColor = color
    }
    if let isShowSelectedView = config.isShowSelectedView {
      bottomView.isShowSelectedView = isShowSelectedView
    }
    if let selectedViewTickColor = config.selectedViewTickColor,
      let color = parseColor(selectedViewTickColor) {
      bottomView.selectedViewTickColor = color
    }
    if let selectedViewTickDarkColor = config.selectedViewTickDarkColor,
      let color = parseColor(selectedViewTickDarkColor) {
      bottomView.selectedViewTickDarkColor = color
    }
  }

  func applyPreviewViewConfig(
    _ config: PreviewViewConfig,
    to previewConfig: inout PreviewViewConfiguration
  ) {
    if let loadNetworkVideoMode = config.loadNetworkVideoMode {
      previewConfig.loadNetworkVideoMode =
        mapLoadNetworkVideoMode(loadNetworkVideoMode)
    }
    if let backgroundColor = config.backgroundColor,
      let color = parseColor(backgroundColor) {
      previewConfig.backgroundColor = color
    }
    if let backgroundDarkColor = config.backgroundDarkColor,
      let color = parseColor(backgroundDarkColor) {
      previewConfig.backgroundDarkColor = color
    }
    if let statusBarHiddenBgColor = config.statusBarHiddenBgColor,
      let color = parseColor(statusBarHiddenBgColor) {
      previewConfig.statusBarHiddenBgColor = color
    }
    if let selectBox = config.selectBox {
      applySelectBoxConfig(selectBox, to: &previewConfig.selectBox)
    }
    if let disableFinishButtonWhenNotSelected =
      config.disableFinishButtonWhenNotSelected {
      previewConfig.disableFinishButtonWhenNotSelected =
        disableFinishButtonWhenNotSelected
    }
    if let videoPlayType = config.videoPlayType {
      previewConfig.videoPlayType = mapPreviewPlayType(videoPlayType)
    }
    if let livePhotoPlayType = config.livePhotoPlayType {
      previewConfig.livePhotoPlayType = mapPreviewPlayType(livePhotoPlayType)
    }
    if let livePhotoMark = config.livePhotoMark {
      applyPreviewLivePhotoMarkConfig(livePhotoMark, to: &previewConfig.livePhotoMark)
    }
    if let HDRMark = config.HDRMark {
      applyPreviewHDRMarkConfig(HDRMark, to: &previewConfig.HDRMark)
    }
    if let singleClickCellAutoPlayVideo =
      config.singleClickCellAutoPlayVideo {
      previewConfig.singleClickCellAutoPlayVideo =
        singleClickCellAutoPlayVideo
    }
    if let maximumZoomScale = config.maximumZoomScale {
      previewConfig.maximumZoomScale = CGFloat(maximumZoomScale)
    }
    if let isShowBottomView = config.isShowBottomView {
      previewConfig.isShowBottomView = isShowBottomView
    }
    if let bottomView = config.bottomView {
      applyPickerBottomViewConfig(bottomView, to: &previewConfig.bottomView)
    }
    if let cancelType = config.cancelType {
      previewConfig.cancelType = mapPickerCancelType(cancelType)
    }
    if let cancelPosition = config.cancelPosition {
      previewConfig.cancelPosition = mapPickerCancelPosition(cancelPosition)
    }
    if let cancelImageName = config.cancelImageName {
      previewConfig.cancelImageName = cancelImageName
    }
    if let cancelDarkImageName = config.cancelDarkImageName {
      previewConfig.cancelDarkImageName = cancelDarkImageName
    }
  }

  func applyPreviewLivePhotoMarkConfig(
    _ config: PreviewViewLivePhotoMarkConfig,
    to markConfig: inout PreviewViewConfiguration.LivePhotoMark
  ) {
    if let allowShow = config.allowShow {
      markConfig.allowShow = allowShow
    }
    if let blurStyle = config.blurStyle {
      markConfig.blurStyle = mapBlurEffectStyle(blurStyle)
    }
    if let blurDarkStyle = config.blurDarkStyle {
      markConfig.blurDarkStyle = mapBlurEffectStyle(blurDarkStyle)
    }
    if let imageColor = config.imageColor,
      let color = parseColor(imageColor) {
      markConfig.imageColor = color
    }
    if let textColor = config.textColor,
      let color = parseColor(textColor) {
      markConfig.textColor = color
    }
    if let imageDarkColor = config.imageDarkColor,
      let color = parseColor(imageDarkColor) {
      markConfig.imageDarkColor = color
    }
    if let textDarkColor = config.textDarkColor,
      let color = parseColor(textDarkColor) {
      markConfig.textDarkColor = color
    }
    if let allowMutedShow = config.allowMutedShow {
      markConfig.allowMutedShow = allowMutedShow
    }
    if let mutedImageColor = config.mutedImageColor,
      let color = parseColor(mutedImageColor) {
      markConfig.mutedImageColor = color
    }
    if let mutedImageDarkColor = config.mutedImageDarkColor,
      let color = parseColor(mutedImageDarkColor) {
      markConfig.mutedImageDarkColor = color
    }
  }

  func applyPreviewHDRMarkConfig(
    _ config: PreviewViewHDRMarkConfig,
    to markConfig: inout PreviewViewConfiguration.HDRMark
  ) {
    if let allowShow = config.allowShow {
      markConfig.allowShow = allowShow
    }
    if let blurStyle = config.blurStyle {
      markConfig.blurStyle = mapBlurEffectStyle(blurStyle)
    }
    if let blurDarkStyle = config.blurDarkStyle {
      markConfig.blurDarkStyle = mapBlurEffectStyle(blurDarkStyle)
    }
    if let imageColor = config.imageColor,
      let color = parseColor(imageColor) {
      markConfig.imageColor = color
    }
    if let imageDarkColor = config.imageDarkColor,
      let color = parseColor(imageDarkColor) {
      markConfig.imageDarkColor = color
    }
  }

  func applySystemCameraConfig(
    _ config: SystemCameraConfig,
    to cameraConfig: inout SystemCameraConfiguration
  ) {
    if let mediaTypes = config.mediaTypes {
      cameraConfig.mediaTypes = mapSystemCameraMediaTypes(mediaTypes)
    }
    if let videoMaximumDuration = config.videoMaximumDuration {
      cameraConfig.videoMaximumDuration = TimeInterval(videoMaximumDuration)
    }
    if let videoQuality = config.videoQuality {
      cameraConfig.videoQuality = mapSystemCameraVideoQuality(videoQuality)
    }
    if let editExportPreset = config.editExportPreset {
      cameraConfig.editExportPreset = mapExportPreset(editExportPreset)
    }
    if let editVideoQuality = config.editVideoQuality {
      cameraConfig.editVideoQuality = Int(editVideoQuality)
    }
    if let cameraDevice = config.cameraDevice {
      cameraConfig.cameraDevice = mapSystemCameraDevice(cameraDevice)
    }
    if let allowsEditing = config.allowsEditing {
      cameraConfig.allowsEditing = allowsEditing
    }
  }

  #if HXPICKER_ENABLE_CAMERA && !targetEnvironment(macCatalyst)
  func applyCameraConfig(
    _ config: CameraConfig,
    to cameraConfig: inout CameraConfiguration
  ) {
    if let modalPresentationStyle = config.modalPresentationStyle {
      cameraConfig.modalPresentationStyle =
        mapModalPresentationStyle(modalPresentationStyle)
    }
    if let languageType = config.languageType {
      cameraConfig.languageType = mapLanguageType(languageType)
    }
    if let prefersStatusBarHidden = config.prefersStatusBarHidden {
      cameraConfig.prefersStatusBarHidden = prefersStatusBarHidden
    }
    if let shouldAutorotate = config.shouldAutorotate {
      cameraConfig.shouldAutorotate = shouldAutorotate
    }
    if let isAutoBack = config.isAutoBack {
      cameraConfig.isAutoBack = isAutoBack
    }
    if let supportedInterfaceOrientations = config.supportedInterfaceOrientations {
      cameraConfig.supportedInterfaceOrientations =
        mapInterfaceOrientations(supportedInterfaceOrientations)
    }
    if let indicatorType = config.indicatorType {
      cameraConfig.indicatorType = mapIndicatorType(indicatorType)
    }
    if let isSaveSystemAlbum = config.isSaveSystemAlbum {
      cameraConfig.isSaveSystemAlbum = isSaveSystemAlbum
    }
    if let saveSystemAlbumType = config.saveSystemAlbumType {
      cameraConfig.saveSystemAlbumType = mapSaveSystemAlbumType(saveSystemAlbumType)
    }
    if let sessionPreset = config.sessionPreset {
      cameraConfig.sessionPreset = mapCameraPreset(sessionPreset)
    }
    if let aspectRatio = config.aspectRatio {
      cameraConfig.aspectRatio = mapCameraAspectRatio(aspectRatio)
    }
    if let position = config.position {
      cameraConfig.position = mapCameraDevicePosition(position)
    }
    if let flashMode = config.flashMode {
      cameraConfig.flashMode = mapCameraFlashMode(flashMode)
    }
    if let videoCodecType = config.videoCodecType {
      cameraConfig.videoCodecType = mapCameraVideoCodecType(videoCodecType)
    }
    if let videoMaximumDuration = config.videoMaximumDuration {
      cameraConfig.videoMaximumDuration = TimeInterval(videoMaximumDuration)
    }
    if let videoMinimumDuration = config.videoMinimumDuration {
      cameraConfig.videoMinimumDuration = TimeInterval(videoMinimumDuration)
    }
    if let takePhotoMode = config.takePhotoMode {
      cameraConfig.takePhotoMode = mapCameraTakePhotoMode(takePhotoMode)
    }
    if let tintColor = config.tintColor,
      let color = parseColor(tintColor) {
      cameraConfig.tintColor = color
    }
    if let focusColor = config.focusColor,
      let color = parseColor(focusColor) {
      cameraConfig.focusColor = color
    }
    if let videoMaxZoomScale = config.videoMaxZoomScale {
      cameraConfig.videoMaxZoomScale = CGFloat(videoMaxZoomScale)
    }
    #if HXPICKER_ENABLE_EDITOR
    if let allowsEditing = config.allowsEditing {
      cameraConfig.allowsEditing = allowsEditing
    }
    #endif
    #if HXPICKER_ENABLE_CAMERA_LOCATION
    if let allowLocation = config.allowLocation {
      cameraConfig.allowLocation = allowLocation
    }
    #endif
  }
  #endif

  #if HXPICKER_ENABLE_EDITOR
  func applyEditorConfig(
    _ config: EditorConfig,
    to editorConfig: inout EditorConfiguration
  ) {
    if let modalPresentationStyle = config.modalPresentationStyle {
      editorConfig.modalPresentationStyle =
        mapModalPresentationStyle(modalPresentationStyle)
    }
    if let languageType = config.languageType {
      editorConfig.languageType = mapLanguageType(languageType)
    }
    if let prefersStatusBarHidden = config.prefersStatusBarHidden {
      editorConfig.prefersStatusBarHidden = prefersStatusBarHidden
    }
    if let shouldAutorotate = config.shouldAutorotate {
      editorConfig.shouldAutorotate = shouldAutorotate
    }
    if let isAutoBack = config.isAutoBack {
      editorConfig.isAutoBack = isAutoBack
    }
    if let supportedInterfaceOrientations = config.supportedInterfaceOrientations {
      editorConfig.supportedInterfaceOrientations =
        mapInterfaceOrientations(supportedInterfaceOrientations)
    }
    if let cancelButtonTitleColor = config.cancelButtonTitleColor,
      let color = parseColor(cancelButtonTitleColor) {
      editorConfig.cancelButtonTitleColor = color
    }
    if let finishButtonTitleNormalColor = config.finishButtonTitleNormalColor,
      let color = parseColor(finishButtonTitleNormalColor) {
      editorConfig.finishButtonTitleNormalColor = color
    }
    if let finishButtonTitleDisableColor = config.finishButtonTitleDisableColor,
      let color = parseColor(finishButtonTitleDisableColor) {
      editorConfig.finishButtonTitleDisableColor = color
    }
    if let isWhetherFinishButtonDisabledInUneditedState =
      config.isWhetherFinishButtonDisabledInUneditedState {
      editorConfig.isWhetherFinishButtonDisabledInUneditedState =
        isWhetherFinishButtonDisabledInUneditedState
    }
    if let buttonType = config.buttonType {
      editorConfig.buttonType = mapEditorButtonType(buttonType)
    }
    if let urlConfig = config.urlConfig {
      editorConfig.urlConfig = mapEditorURLConfig(urlConfig)
    }
    if let photo = config.photo {
      applyEditorPhotoConfig(photo, to: &editorConfig.photo)
    }
    if let video = config.video {
      applyEditorVideoConfig(video, to: &editorConfig.video)
    }
    if let brush = config.brush {
      applyEditorBrushConfig(brush, to: &editorConfig.brush)
    }
    if let chartlet = config.chartlet {
      applyEditorChartletConfig(chartlet, to: &editorConfig.chartlet)
    }
    if let text = config.text {
      applyEditorTextConfig(text, to: &editorConfig.text)
    }
    if let cropSize = config.cropSize {
      applyEditorCropSizeConfig(cropSize, to: &editorConfig.cropSize)
    }
    if let mosaic = config.mosaic {
      applyEditorMosaicConfig(mosaic, to: &editorConfig.mosaic)
    }
    if let isFixedCropSizeState = config.isFixedCropSizeState {
      editorConfig.isFixedCropSizeState = isFixedCropSizeState
    }
    if let isIgnoreCropTimeWhenFixedCropSizeState =
      config.isIgnoreCropTimeWhenFixedCropSizeState {
      editorConfig.isIgnoreCropTimeWhenFixedCropSizeState =
        isIgnoreCropTimeWhenFixedCropSizeState
    }
    if let toolsView = config.toolsView {
      applyEditorToolsViewConfig(toolsView, to: &editorConfig.toolsView)
    }
    if let indicatorType = config.indicatorType {
      editorConfig.indicatorType = mapIndicatorType(indicatorType)
    }
  }

  func applyEditorPhotoConfig(
    _ config: EditorPhotoConfig,
    to photoConfig: inout EditorConfiguration.Photo
  ) {
    if let scale = config.scale {
      photoConfig.scale = CGFloat(scale)
    }
    if let defaultSelectedToolOption = config.defaultSelectedToolOption {
      photoConfig.defaultSelectedToolOption =
        mapEditorToolType(defaultSelectedToolOption)
    }
    if let filterScale = config.filterScale {
      photoConfig.filterScale = CGFloat(filterScale)
    }
    if let filter = config.filter {
      applyEditorFilterConfig(filter, to: &photoConfig.filter)
    }
  }

  func applyEditorVideoConfig(
    _ config: EditorVideoConfig,
    to videoConfig: inout EditorConfiguration.Video
  ) {
    if let preset = config.preset {
      videoConfig.preset = mapExportPreset(preset)
    }
    if let quality = config.quality {
      videoConfig.quality = Int(quality)
    }
    if let isAutoPlay = config.isAutoPlay {
      videoConfig.isAutoPlay = isAutoPlay
    }
    if let defaultSelectedToolOption = config.defaultSelectedToolOption {
      videoConfig.defaultSelectedToolOption =
        mapEditorToolType(defaultSelectedToolOption)
    }
    if let music = config.music {
      applyEditorMusicConfig(music, to: &videoConfig.music)
    }
    if let cropTime = config.cropTime {
      applyEditorVideoCropTimeConfig(cropTime, to: &videoConfig.cropTime)
    }
    if let filter = config.filter {
      applyEditorFilterConfig(filter, to: &videoConfig.filter)
    }
  }

  func applyEditorVideoCropTimeConfig(
    _ config: EditorVideoCropTimeConfig,
    to cropTime: inout EditorConfiguration.Video.CropTime
  ) {
    if let maximumTime = config.maximumTime {
      cropTime.maximumTime = TimeInterval(maximumTime)
    }
    if let minimumTime = config.minimumTime {
      cropTime.minimumTime = TimeInterval(minimumTime)
    }
    if let arrowNormalColor = config.arrowNormalColor,
      let color = parseColor(arrowNormalColor) {
      cropTime.arrowNormalColor = color
    }
    if let arrowHighlightedColor = config.arrowHighlightedColor,
      let color = parseColor(arrowHighlightedColor) {
      cropTime.arrowHighlightedColor = color
    }
    if let frameHighlightedColor = config.frameHighlightedColor,
      let color = parseColor(frameHighlightedColor) {
      cropTime.frameHighlightedColor = color
    }
  }

  func applyEditorBrushConfig(
    _ config: EditorBrushConfig,
    to brushConfig: inout EditorConfiguration.Brush
  ) {
    if let colors = config.colors {
      brushConfig.colors = colors
    }
    if let defaultColorIndex = config.defaultColorIndex {
      brushConfig.defaultColorIndex = Int(defaultColorIndex)
    }
    if let lineWidth = config.lineWidth {
      brushConfig.lineWidth = CGFloat(lineWidth)
    }
    if let maximumLinewidth = config.maximumLinewidth {
      brushConfig.maximumLinewidth = CGFloat(maximumLinewidth)
    }
    if let minimumLinewidth = config.minimumLinewidth {
      brushConfig.minimumLinewidth = CGFloat(minimumLinewidth)
    }
    if let showSlider = config.showSlider {
      brushConfig.showSlider = showSlider
    }
    if let addCustomColor = config.addCustomColor {
      brushConfig.addCustomColor = addCustomColor
    }
    if let customDefaultColor = config.customDefaultColor,
      let color = parseColor(customDefaultColor) {
      brushConfig.customDefaultColor = color
    }
    if let isHideStickersDuringDrawing = config.isHideStickersDuringDrawing {
      brushConfig.isHideStickersDuringDrawing = isHideStickersDuringDrawing
    }
  }

  func applyEditorFilterConfig(
    _ config: EditorFilterConfig,
    to filterConfig: inout EditorConfiguration.Filter
  ) {
    if let selectedColor = config.selectedColor,
      let color = parseColor(selectedColor) {
      filterConfig.selectedColor = color
    }
    if let identifier = config.identifier {
      filterConfig.identifier = identifier
    }
  }

  func applyEditorMusicConfig(
    _ config: EditorMusicConfig,
    to musicConfig: inout EditorConfiguration.Music
  ) {
    if let showSearch = config.showSearch {
      musicConfig.showSearch = showSearch
    }
    if let tintColor = config.tintColor,
      let color = parseColor(tintColor) {
      musicConfig.tintColor = color
    }
    if let finishButtonTitleColor = config.finishButtonTitleColor,
      let color = parseColor(finishButtonTitleColor) {
      musicConfig.finishButtonTitleColor = color
    }
    if let finishButtonBackgroundColor = config.finishButtonBackgroundColor,
      let color = parseColor(finishButtonBackgroundColor) {
      musicConfig.finishButtonBackgroundColor = color
    }
    if let placeholder = config.placeholder {
      musicConfig.placeholder = placeholder
    }
    if let autoPlayWhenScrollingStops = config.autoPlayWhenScrollingStops {
      musicConfig.autoPlayWhenScrollingStops = autoPlayWhenScrollingStops
    }
  }

  func applyEditorTextConfig(
    _ config: EditorTextConfig,
    to textConfig: inout EditorConfiguration.Text
  ) {
    if let colors = config.colors {
      textConfig.colors = colors
    }
    if let tintColor = config.tintColor,
      let color = parseColor(tintColor) {
      textConfig.tintColor = color
    }
    if let doneTitleColor = config.doneTitleColor,
      let color = parseColor(doneTitleColor) {
      textConfig.doneTitleColor = color
    }
    if let doneBackgroundColor = config.doneBackgroundColor,
      let color = parseColor(doneBackgroundColor) {
      textConfig.doneBackgroundColor = color
    }
    if let font = config.font,
      let fontValue = parseFont(font) {
      textConfig.font = fontValue
    }
    if let maximumLimitTextLength = config.maximumLimitTextLength {
      textConfig.maximumLimitTextLength = Int(maximumLimitTextLength)
    }
    if let modalPresentationStyle = config.modalPresentationStyle {
      textConfig.modalPresentationStyle =
        mapModalPresentationStyle(modalPresentationStyle)
    }
  }

  func applyEditorMosaicConfig(
    _ config: EditorMosaicConfig,
    to mosaicConfig: inout EditorConfiguration.Mosaic
  ) {
    if let mosaicWidth = config.mosaicWidth {
      mosaicConfig.mosaicWidth = CGFloat(mosaicWidth)
    }
    if let mosaiclineWidth = config.mosaiclineWidth {
      mosaicConfig.mosaiclineWidth = CGFloat(mosaiclineWidth)
    }
    if let smearWidth = config.smearWidth {
      mosaicConfig.smearWidth = CGFloat(smearWidth)
    }
    if let isFilterApply = config.isFilterApply {
      mosaicConfig.isFilterApply = isFilterApply
    }
    if let isHideStickersDuringDrawing = config.isHideStickersDuringDrawing {
      mosaicConfig.isHideStickersDuringDrawing = isHideStickersDuringDrawing
    }
  }

  func applyEditorChartletConfig(
    _ config: EditorChartletConfig,
    to chartletConfig: inout EditorConfiguration.Chartlet
  ) {
    if let modalPresentationStyle = config.modalPresentationStyle {
      chartletConfig.modalPresentationStyle =
        mapModalPresentationStyle(modalPresentationStyle)
    }
    if let rowCount = config.rowCount {
      chartletConfig.rowCount = Int(rowCount)
    }
    if let loadScene = config.loadScene {
      chartletConfig.loadScene = mapEditorChartletLoadScene(loadScene)
    }
    #if HXPICKER_ENABLE_PICKER
    if let allowAddAlbum = config.allowAddAlbum {
      chartletConfig.allowAddAlbum = allowAddAlbum
    }
    #endif
    if let albumImageName = config.albumImageName {
      chartletConfig.albumImageName = albumImageName
    }
    if let titles = config.titles {
      let mappedTitles = titles.compactMap(mapChartletItem)
      if !mappedTitles.isEmpty {
        chartletConfig.titles = mappedTitles
      }
    }
    if let lists = config.lists {
      let mappedLists = lists.map { $0.compactMap(mapChartletItem) }
      chartletConfig.listHandler = { titleIndex, response in
        let list: [EditorChartlet]
        if titleIndex >= 0 && titleIndex < mappedLists.count {
          list = mappedLists[titleIndex]
        } else {
          list = []
        }
        response(titleIndex, list)
      }
    }
  }

  func applyEditorCropSizeConfig(
    _ config: EditorCropSizeConfig,
    to cropConfig: inout EditorConfiguration.CropSize
  ) {
    if let angleScaleColor = config.angleScaleColor,
      let color = parseColor(angleScaleColor) {
      cropConfig.angleScaleColor = color
    }
    if let isRoundCrop = config.isRoundCrop {
      cropConfig.isRoundCrop = isRoundCrop
    }
    if let isFixedRatio = config.isFixedRatio {
      cropConfig.isFixedRatio = isFixedRatio
    }
    if let aspectRatio = config.aspectRatio {
      cropConfig.aspectRatio = toCGSize(aspectRatio)
    }
    if let maskType = config.maskType,
       let mapped = mapEditorMaskType(maskType) {
      cropConfig.maskType = mapped
    }
    if let isShowScaleSize = config.isShowScaleSize {
      cropConfig.isShowScaleSize = isShowScaleSize
    }
    if let defaultSeletedIndex = config.defaultSeletedIndex {
      cropConfig.defaultSeletedIndex = Int(defaultSeletedIndex)
    }
    if let aspectRatios = config.aspectRatios {
      cropConfig.aspectRatios = aspectRatios.map(mapEditorRatioConfig)
    }
    if let isResetToOriginal = config.isResetToOriginal {
      cropConfig.isResetToOriginal = isResetToOriginal
    }
    if let maskRowCount = config.maskRowCount {
      cropConfig.maskRowCount = CGFloat(maskRowCount)
    }
    if let maskLandscapeRowNumber = config.maskLandscapeRowNumber {
      cropConfig.maskLandscapeRowNumber = CGFloat(maskLandscapeRowNumber)
    }
  }

  func applyEditorToolsViewConfig(
    _ config: EditorToolsViewConfig,
    to toolsView: inout EditorConfiguration.ToolsView
  ) {
    if let toolOptions = config.toolOptions {
      toolsView.toolOptions = toolOptions.compactMap { option in
        mapEditorToolOption(option.type)
      }
    }
    if let toolSelectedColor = config.toolSelectedColor,
      let color = parseColor(toolSelectedColor) {
      toolsView.toolSelectedColor = color
    }
    if let musicTickColor = config.musicTickColor,
      let color = parseColor(musicTickColor) {
      toolsView.musicTickColor = color
    }
    if let musicTickBackgroundColor = config.musicTickBackgroundColor,
      let color = parseColor(musicTickBackgroundColor) {
      toolsView.musicTickBackgroundColor = color
    }
  }
  #endif
}

private extension HXPhotoPickerImpl {
  func mapChartletItem(_ item: EditorChartletItemConfig) -> EditorChartlet? {
    guard let uri = item.uri, !uri.isEmpty else {
      return nil
    }
    if uri.hasPrefix("data:") {
      if let base64Index = uri.range(of: "base64,")?.upperBound {
        let base64 = String(uri[base64Index...])
        if let data = Data(base64Encoded: base64),
          let image = UIImage(data: data) {
          return EditorChartlet(image: image, imageData: data)
        }
      }
      return nil
    }
    if let url = URL(string: uri) {
      if url.isFileURL,
        let data = try? Data(contentsOf: url),
        let image = UIImage(data: data) {
        return EditorChartlet(image: image, imageData: data)
      }
      return EditorChartlet(url: url)
    }
    return nil
  }

  func mapPickerAssetOptions(
    _ options: [PickerAssetOption]
  ) -> PickerAssetOptions {
    var mapped: PickerAssetOptions = []
    for option in options {
      switch option {
      case .photo:
        mapped.insert(.photo)
      case .video:
        mapped.insert(.video)
      case .gifphoto:
        mapped.insert(.gifPhoto)
      case .livephoto:
        mapped.insert(.livePhoto)
      case .hdrphoto:
        mapped.insert(.HDRPhoto)
      }
    }
    return mapped
  }

  func mapPickerSelectMode(
    _ mode: PickerSelectModeOption
  ) -> PickerSelectMode {
    switch mode {
    case .single:
      return .single
    case .multiple:
      return .multiple
    }
  }

  func mapPickerPresentStyle(
    _ config: PickerPresentStyleConfig
  ) -> PickerPresentStyle {
    let rightSwipe: PickerPresentStyle.RightSwipe? =
      config.rightSwipeTriggerRange.map {
        PickerPresentStyle.RightSwipe(CGFloat($0))
      }
    switch config.type {
    case .some(.none):
      return .none
    case .some(.present):
      return .present(rightSwipe: rightSwipe)
    case .some(.push):
      return .push(rightSwipe: rightSwipe)
    case .none:
      return .present(rightSwipe: rightSwipe)
    }
  }

  func mapAlbumShowMode(_ config: AlbumShowModeConfig) -> AlbumShowMode {
    switch config.type {
    case .normal:
      return .normal
    case .popup:
      return .popup
    case .present:
      let style = config.modalPresentationStyle.map(mapModalPresentationStyle)
        ?? defaultModalPresentationStyle()
      return .present(style)
    case nil:
      return .normal
    }
  }

  func mapSelectionTapAction(
    _ action: SelectionTapActionOption
  ) -> SelectionTapAction {
    switch action {
    case .preview:
      return .preview
    case .quickselect:
      return .quickSelect
    case .openeditor:
      return .openEditor
    }
  }

  func mapSort(_ sort: SortOption) -> Sort {
    switch sort {
    case .asc:
      return .asc
    case .desc:
      return .desc
    }
  }

  func mapPreviewJumpStyle(
    _ style: PhotoPickerPreviewJumpStyleOption
  ) -> PhotoPickerPreviewJumpStyle {
    switch style {
    case .push:
      return .push
    case .present:
      return .present
    }
  }

  func mapPreviewPlayType(
    _ style: PreviewPlayTypeOption
  ) -> PhotoPreviewViewController.PlayType {
    switch style {
    case .normal:
      return .normal
    case .auto:
      return .auto
    case .once:
      return .once
    }
  }

  func mapLoadNetworkVideoMode(
    _ mode: LoadNetworkVideoModeOption
  ) -> PhotoAsset.LoadNetworkVideoMode {
    switch mode {
    case .download:
      return .download
    case .play:
      return .play
    }
  }

  func mapSelectBoxStyle(
    _ style: SelectBoxStyleOption
  ) -> SelectBoxView.Style {
    switch style {
    case .number:
      return .number
    case .tick:
      return .tick
    }
  }

  func mapPickerCancelType(
    _ type: PickerViewCancelTypeOption
  ) -> PhotoPickerViewController.CancelType {
    switch type {
    case .text:
      return .text
    case .image:
      return .image
    }
  }

  func mapPickerCancelPosition(
    _ position: PickerViewCancelPositionOption
  ) -> PhotoPickerViewController.CancelPosition {
    switch position {
    case .left:
      return .left
    case .right:
      return .right
    }
  }

  func mapAppearanceStyle(_ style: AppearanceStyleOption) -> AppearanceStyle {
    switch style {
    case .varied:
      return .varied
    case .normal:
      return .normal
    case .dark:
      return .dark
    }
  }

  func mapIndicatorType(_ type: IndicatorTypeOption) -> IndicatorType {
    switch type {
    case .circle:
      return .circle
    case .circlejoin:
      return .circleJoin
    case .system:
      return .system
    }
  }

  func mapStatusBarStyle(
    _ style: StatusBarStyleOption
  ) -> UIStatusBarStyle {
    switch style {
    case .default:
      return .default
    case .lightcontent:
      return .lightContent
    case .darkcontent:
      if #available(iOS 13.0, *) {
        return .darkContent
      }
      return .default
    }
  }

  func mapBarStyle(_ style: BarStyleOption) -> UIBarStyle {
    switch style {
    case .default:
      return .default
    case .black:
      return .black
    }
  }

  func mapActivityIndicatorStyle(
    _ style: ActivityIndicatorStyleOption
  ) -> UIActivityIndicatorView.Style {
    switch style {
    case .gray:
      return .gray
    case .white:
      return .white
    case .large:
      if #available(iOS 13.0, *) {
        return .large
      }
      return .whiteLarge
    case .medium:
      if #available(iOS 13.0, *) {
        return .medium
      }
      return .gray
    }
  }

  func mapBlurEffectStyle(
    _ style: BlurEffectStyleOption
  ) -> UIBlurEffect.Style {
    switch style {
    case .extralight:
      return .extraLight
    case .light:
      return .light
    case .dark:
      return .dark
    case .regular:
      if #available(iOS 10.0, *) {
        return .regular
      }
      return .light
    case .prominent:
      if #available(iOS 10.0, *) {
        return .prominent
      }
      return .dark
    case .systemultrathinmaterial:
      if #available(iOS 13.0, *) {
        return .systemUltraThinMaterial
      }
      return .regular
    case .systemthinmaterial:
      if #available(iOS 13.0, *) {
        return .systemThinMaterial
      }
      return .regular
    case .systemmaterial:
      if #available(iOS 13.0, *) {
        return .systemMaterial
      }
      return .regular
    case .systemthickmaterial:
      if #available(iOS 13.0, *) {
        return .systemThickMaterial
      }
      return .regular
    case .systemchromematerial:
      if #available(iOS 13.0, *) {
        return .systemChromeMaterial
      }
      return .regular
    }
  }

  func mapModalPresentationStyle(
    _ style: ModalPresentationStyleOption
  ) -> UIModalPresentationStyle {
    switch style {
    case .fullscreen:
      return .fullScreen
    case .pagesheet:
      return .pageSheet
    case .formsheet:
      return .formSheet
    case .currentcontext:
      return .currentContext
    case .custom:
      return .custom
    case .overfullscreen:
      return .overFullScreen
    case .overcurrentcontext:
      return .overCurrentContext
    case .popover:
      return .popover
    case .automatic:
      return defaultModalPresentationStyle()
    }
  }

  func defaultModalPresentationStyle() -> UIModalPresentationStyle {
    if #available(iOS 13.0, *) {
      return .automatic
    }
    return .fullScreen
  }

  func mapInterfaceOrientations(
    _ orientations: [InterfaceOrientationOption]
  ) -> UIInterfaceOrientationMask {
    var mask: UIInterfaceOrientationMask = []
    for orientation in orientations {
      switch orientation {
      case .portrait:
        mask.insert(.portrait)
      case .portraitupsidedown:
        mask.insert(.portraitUpsideDown)
      case .landscapeleft:
        mask.insert(.landscapeLeft)
      case .landscaperight:
        mask.insert(.landscapeRight)
      }
    }
    return mask.isEmpty ? .all : mask
  }

  func mapLanguageType(_ type: LanguageTypeOption) -> LanguageType {
    switch type {
    case .system:
      return .system
    case .simplifiedchinese:
      return .simplifiedChinese
    case .traditionalchinese:
      return .traditionalChinese
    case .japanese:
      return .japanese
    case .korean:
      return .korean
    case .english:
      return .english
    case .thai:
      return .thai
    case .indonesia:
      return .indonesia
    case .vietnamese:
      return .vietnamese
    case .russian:
      return .russian
    case .german:
      return .german
    case .french:
      return .french
    case .arabic:
      return .arabic
    case .spanish:
      return .spanish
    case .portuguese:
      return .portuguese
    case .amharic:
      return .amharic
    case .bengali:
      return .bengali
    case .divehi:
      return .divehi
    case .persian:
      return .persian
    case .filipino:
      return .filipino
    case .hausa:
      return .hausa
    case .hebrew:
      return .hebrew
    case .hindi:
      return .hindi
    case .italian:
      return .italian
    case .malay:
      return .malay
    case .nepali:
      return .nepali
    case .punjabi:
      return .punjabi
    case .sinhala:
      return .sinhala
    case .swahili:
      return .swahili
    case .syriac:
      return .syriac
    case .turkish:
      return .turkish
    case .ukrainian:
      return .ukrainian
    case .urdu:
      return .urdu
    }
  }

  func mapPhotoListCameraType(
    _ config: PhotoListCameraTypeConfig
  ) -> PhotoListConfiguration.CameraType? {
    switch config.type {
    case .system:
      var systemConfig = SystemCameraConfiguration()
      if let systemConfigInput = config.systemConfig {
        applySystemCameraConfig(systemConfigInput, to: &systemConfig)
      }
      return .system(systemConfig)
    case .custom:
      #if HXPICKER_ENABLE_CAMERA && !targetEnvironment(macCatalyst)
      var customConfig = CameraConfiguration()
      if let customConfigInput = config.customConfig {
        applyCameraConfig(customConfigInput, to: &customConfig)
      }
      return .custom(customConfig)
      #else
      return nil
      #endif
    case nil:
      return nil
    }
  }

  func mapSaveSystemAlbumType(
    _ config: PhotoListSaveSystemAlbumTypeConfig
  ) -> AssetSaveUtil.AlbumType {
    switch config.type {
    case .some(.none):
      return .none
    case .some(.displayname):
      return .displayName
    case .some(.custom):
      return .custom(config.customAlbumName ?? "")
    case .none:
      if let name = config.customAlbumName {
        return .custom(name)
      }
      return .displayName
    }
  }

  func mapSystemCameraMediaTypes(
    _ types: [SystemCameraMediaTypeOption]
  ) -> [String] {
    types.map { type in
      switch type {
      case .image:
        return kUTTypeImage as String
      case .video:
        return kUTTypeMovie as String
      }
    }
  }

  func mapSystemCameraVideoQuality(
    _ quality: SystemCameraVideoQualityOption
  ) -> UIImagePickerController.QualityType {
    switch quality {
    case .typehigh:
      return .typeHigh
    case .typemedium:
      return .typeMedium
    case .typelow:
      return .typeLow
    case .type640x480:
      return .type640x480
    case .typeiframe960x540:
      return .typeIFrame960x540
    case .typeiframe1280x720:
      return .typeIFrame1280x720
    }
  }

  func mapSystemCameraDevice(
    _ device: SystemCameraDeviceOption
  ) -> UIImagePickerController.CameraDevice {
    switch device {
    case .rear:
      return .rear
    case .front:
      return .front
    }
  }

  func mapExportPreset(_ preset: ExportPresetOption) -> ExportPreset {
    switch preset {
    case .lowquality:
      return .lowQuality
    case .mediumquality:
      return .mediumQuality
    case .highquality:
      return .highQuality
    case .ratio640x480:
      return .ratio_640x480
    case .ratio960x540:
      return .ratio_960x540
    case .ratio1280x720:
      return .ratio_1280x720
    }
  }

  #if HXPICKER_ENABLE_CAMERA && !targetEnvironment(macCatalyst)
  func mapCameraPreset(_ preset: CameraPresetOption) -> CameraConfiguration.Preset {
    switch preset {
    case .vga640x480:
      return .vga640x480
    case .iframe960x540:
      return .iFrame960x540
    case .hd1280x720:
      return .hd1280x720
    case .hd1920x1080:
      return .hd1920x1080
    case .hd4k3840x2160:
      return .hd4K3840x2160
    }
  }

  func mapCameraAspectRatio(
    _ ratio: CameraAspectRatioConfig
  ) -> CameraConfiguration.AspectRatio {
    switch ratio.type {
    case .fullscreen:
      return .fullScreen
    case .ratio9x16:
      return ._9x16
    case .ratio16x9:
      return ._16x9
    case .ratio3x4:
      return ._3x4
    case .ratio1x1:
      return ._1x1
    case .custom:
      if let size = ratio.size {
        return .custom(toCGSize(size))
      }
      return .fullScreen
    case nil:
      return .fullScreen
    }
  }

  func mapCameraDevicePosition(
    _ position: CameraDevicePositionOption
  ) -> CameraConfiguration.DevicePosition {
    switch position {
    case .back:
      return .back
    case .front:
      return .front
    }
  }

  func mapCameraFlashMode(
    _ flashMode: CameraFlashModeOption
  ) -> AVCaptureDevice.FlashMode {
    switch flashMode {
    case .off:
      return .off
    case .on:
      return .on
    case .auto:
      return .auto
    }
  }

  func mapCameraVideoCodecType(
    _ codecType: CameraVideoCodecTypeOption
  ) -> AVVideoCodecType {
    switch codecType {
    case .h264:
      return .h264
    case .hevc:
      if #available(iOS 11.0, *) {
        return .hevc
      }
      return .h264
    }
  }

  func mapCameraTakePhotoMode(
    _ mode: CameraTakePhotoModeOption
  ) -> CameraConfiguration.TakePhotoMode {
    switch mode {
    case .press:
      return .press
    case .click:
      return .click
    }
  }
  #endif

  #if HXPICKER_ENABLE_EDITOR
  func mapEditorJumpStyle(
    _ style: EditorJumpStyleConfig
  ) -> EditorJumpStyle {
    switch style.type {
    case .push:
      return .push(mapEditorJumpPushStyle(style.pushStyle))
    case .present:
      return .present(mapEditorJumpPresentStyle(style.presentStyle))
    case nil:
      return .push()
    }
  }

  func mapEditorJumpPushStyle(
    _ style: EditorJumpPushStyleOption?
  ) -> EditorJumpStyle.PushStyle {
    switch style {
    case .normal:
      return .normal
    case .custom:
      return .custom
    case nil:
      return .custom
    }
  }

  func mapEditorJumpPresentStyle(
    _ style: EditorJumpPresentStyleOption?
  ) -> EditorJumpStyle.PresentStyle {
    switch style {
    case .automatic:
      return .automatic
    case .fullscreen:
      return .fullScreen
    case .custom:
      return .custom
    case nil:
      return .automatic
    }
  }

  func mapEditorButtonType(
    _ type: EditorButtonTypeOption
  ) -> EditorConfiguration.ButtonType {
    switch type {
    case .top:
      return .top
    case .bottom:
      return .bottom
    }
  }

  func mapEditorToolType(
    _ type: EditorToolOption
  ) -> EditorConfiguration.ToolsView.Options.Type {
    switch type {
    case .time:
      return .time
    case .graffiti:
      return .graffiti
    case .chartlet:
      return .chartlet
    case .text:
      return .text
    case .mosaic:
      return .mosaic
    case .filteredit:
      return .filterEdit
    case .filter:
      return .filter
    case .music:
      return .music
    case .cropsize:
      return .cropSize
    }
  }

  func mapEditorToolOption(
    _ type: EditorToolOption
  ) -> EditorConfiguration.ToolsView.Options? {
    switch type {
    case .time:
      return .init(imageType: .imageResource.editor.tools.video, type: .time)
    case .graffiti:
      return .init(imageType: .imageResource.editor.tools.graffiti, type: .graffiti)
    case .chartlet:
      return .init(imageType: .imageResource.editor.tools.chartlet, type: .chartlet)
    case .text:
      return .init(imageType: .imageResource.editor.tools.text, type: .text)
    case .mosaic:
      return .init(imageType: .imageResource.editor.tools.mosaic, type: .mosaic)
    case .filteredit:
      return .init(
        imageType: .imageResource.editor.tools.adjustment,
        type: .filterEdit
      )
    case .filter:
      return .init(imageType: .imageResource.editor.tools.filter, type: .filter)
    case .music:
      return .init(imageType: .imageResource.editor.tools.music, type: .music)
    case .cropsize:
      return .init(imageType: .imageResource.editor.tools.cropSize, type: .cropSize)
    }
  }

  func mapEditorChartletLoadScene(
    _ scene: EditorChartletLoadSceneOption
  ) -> EditorConfiguration.Chartlet.LoadScene {
    switch scene {
    case .celldisplay:
      return .cellDisplay
    case .scrollstop:
      return .scrollStop
    }
  }

  func mapEditorURLConfig(_ config: EditorURLConfig) -> HXPhotoPicker.EditorURLConfig {
    return .init(fileName: config.fileName, type: mapEditorURLPathType(config.pathType))
  }

  func mapEditorURLPathType(
    _ type: EditorURLPathTypeOption
  ) -> HXPhotoPicker.EditorURLConfig.PathType {
    switch type {
    case .document:
      return .document
    case .caches:
      return .caches
    case .temp:
      return .temp
    }
  }

  func mapEditorRatioConfig(_ config: EditorRatioConfig) -> EditorRatioToolConfig {
    return .init(
      title: .custom(config.title),
      titleNormalColor: config.titleNormalColor ?? "#a1a1a1",
      titleSelectedColor: config.titleSelectedColor ?? "#ebebeb",
      backgroundNormalColor: config.backgroundNormalColor ?? "",
      backgroundSelectedColor: config.backgroundSelectedColor ?? "#66D6D6D6",
      ratio: toCGSize(config.ratio)
    )
  }

  func mapEditorMaskType(
    _ config: EditorMaskTypeConfig
  ) -> EditorView.MaskType? {
    switch config.type {
    case .blureffect:
      let style = config.blurStyle.map(mapBlurEffectStyle) ?? .dark
      return .blurEffect(style: style)
    case .customcolor:
      if let colorValue = config.color,
         let color = parseColor(colorValue) {
        return .customColor(color: color)
      }
      return nil
    case nil:
      return nil
    }
  }
  #endif

  func toCGSize(_ value: Size) -> CGSize {
    return CGSize(width: CGFloat(value.width), height: CGFloat(value.height))
  }

  func parseFont(_ config: FontConfig) -> UIFont? {
    let size = CGFloat(config.size)
    if let name = config.name, let font = UIFont(name: name, size: size) {
      return font
    }
    if config.family == .pingfang {
      let name = pingFangName(for: config.weight)
      if let font = UIFont(name: name, size: size) {
        return font
      }
    }
    return UIFont.systemFont(ofSize: size, weight: mapFontWeight(config.weight))
  }

  func mapFontWeight(_ weight: FontWeightOption?) -> UIFont.Weight {
    switch weight {
    case .ultralight:
      return .ultraLight
    case .thin:
      return .thin
    case .light:
      return .light
    case .regular:
      return .regular
    case .medium:
      return .medium
    case .semibold:
      return .semibold
    case .bold:
      return .bold
    case .heavy:
      return .heavy
    case .black:
      return .black
    case nil:
      return .regular
    }
  }

  func pingFangName(for weight: FontWeightOption?) -> String {
    switch weight {
    case .ultralight:
      return "PingFangSC-Ultralight"
    case .thin:
      return "PingFangSC-Thin"
    case .light:
      return "PingFangSC-Light"
    case .medium:
      return "PingFangSC-Medium"
    case .semibold:
      return "PingFangSC-Semibold"
    case .bold:
      return "PingFangSC-Bold"
    case .heavy:
      return "PingFangSC-Heavy"
    case .black:
      return "PingFangSC-Black"
    case .regular, nil:
      return "PingFangSC-Regular"
    }
  }

  func parseColor(_ value: String) -> UIColor? {
    let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmed.isEmpty {
      return nil
    }

    let hexString: String
    if trimmed.hasPrefix("#") {
      hexString = String(trimmed.dropFirst())
    } else {
      hexString = trimmed
    }

    guard hexString.count == 6 || hexString.count == 8 else {
      return nil
    }

    var hexNumber: UInt64 = 0
    guard Scanner(string: hexString).scanHexInt64(&hexNumber) else {
      return nil
    }

    let r, g, b, a: CGFloat
    if hexString.count == 8 {
      r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255.0
      g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255.0
      b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255.0
      a = CGFloat(hexNumber & 0x000000FF) / 255.0
    } else {
      r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
      g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
      b = CGFloat(hexNumber & 0x0000FF) / 255.0
      a = 1.0
    }

    return UIColor(red: r, green: g, blue: b, alpha: a)
  }
}
