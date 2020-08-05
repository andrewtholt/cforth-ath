#include "stm32f10x_conf.h"
USART_TypeDef *tty2;

void init_uart() {
    tty2 = USART2;

    RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART2, ENABLE);

    GPIO_InitTypeDef gpioInit = {
        .GPIO_Speed = GPIO_Speed_50MHz
    };

    //     
    // Configure USART2 Tx (PA.2) as alternate function push-pull.    
    //     
    gpioInit.GPIO_Pin = GPIO_Pin_2;    
    gpioInit.GPIO_Mode = GPIO_Mode_AF_PP;    
    gpioInit.GPIO_Speed = GPIO_Speed_50MHz;    
    GPIO_Init(GPIOA, &gpioInit);    
    //     
    // Configure USART2 Rx (PA.3) as input floating.    
    //    
    gpioInit.GPIO_Pin = GPIO_Pin_3;    
    gpioInit.GPIO_Mode = GPIO_Mode_IN_FLOATING;    
    GPIO_Init(GPIOA, &gpioInit);


    USART_InitTypeDef tty2Init = {
        .USART_BaudRate   = 115200,
        .USART_WordLength = USART_WordLength_8b,
        .USART_StopBits   = USART_StopBits_1,
        .USART_Parity     = USART_Parity_No,
        .USART_Mode       = USART_Mode_Rx | USART_Mode_Tx,
        .USART_HardwareFlowControl = USART_HardwareFlowControl_None
    };

    USART_Init(tty2, &tty2Init);
    USART_Cmd(tty2, ENABLE);
}
//     
// TODO ATH Generalised version of kbhit    
//    
int byteWaiting(USART_TypeDef *p) {
    return USART_GetFlagStatus(p, USART_FLAG_RXNE);
}

//
// TODO ATH Generalised version of getkey
//
int getByte(USART_TypeDef *p) {
    int c;
    while (!byteWaiting(p))
        ;
    return USART_ReceiveData(p);
}

