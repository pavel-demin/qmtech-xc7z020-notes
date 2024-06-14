#include "xemacps.h"

u32 SetMacAddress()
{
  XEmacPs Emac;
  XEmacPs_Config *EmacConfig;
  u32 Status;
  u8 Buffer[6] = {0x52, 0x54, 0xC0, 0xA8, 0x01, 0x64};

  EmacConfig = XEmacPs_LookupConfig(XPAR_PS7_ETHERNET_0_DEVICE_ID);
  if(EmacConfig == NULL) return XST_FAILURE;

  Status = XEmacPs_CfgInitialize(&Emac, EmacConfig, EmacConfig->BaseAddress);
  if(Status != XST_SUCCESS) return XST_FAILURE;

  Status = XEmacPs_SetMacAddress(&Emac, Buffer, 1);
  if(Status != XST_SUCCESS) return XST_FAILURE;

  return Status;
}
