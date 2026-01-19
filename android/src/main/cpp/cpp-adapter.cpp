#include <jni.h>
#include "NitroHxPhotoPickerOnLoad.hpp"

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* vm, void*) {
  return margelo::nitro::hxphotopicker::initialize(vm);
}
