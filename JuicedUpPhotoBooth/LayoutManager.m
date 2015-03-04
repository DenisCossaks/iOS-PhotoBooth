//
//  LayoutManager.m
//  PhotoBooth
//
//  Created by LiYang on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LayoutManager.h"
#import "CustomCanvas.h"

@implementation LayoutManager

+(NSMutableArray *) createLayoutInView:(UIView *) view layout: (int) layoutIndex
{
    CGRect canvasRect;
    CGRect frameRect = view.frame;
    NSMutableArray *canvasArray = [NSMutableArray arrayWithCapacity:0];
    
    switch (layoutIndex)
    {
        case 0:
            {
                CustomCanvas *canvas;
                canvasRect = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height);
                canvas = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                canvas.leftLayers = nil;
                canvas.rightLayers = nil;
                canvas.upperLayers = nil;
                canvas.downLayers = nil;
                canvas.flatLayers = [NSMutableArray arrayWithObjects:canvas, nil];

                [canvasArray addObject:canvas];
                [view addSubview:canvas];
                [canvas release];
            }
            break;     
        case 1:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height/2);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            

                canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width, frameRect.size.height/2);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = nil;
                canvas1.upperLayers = nil;
                canvas1.downLayers = arr2;
                canvas1.flatLayers = arr1;
                
                canvas2.leftLayers = nil;
                canvas2.rightLayers = nil;
                canvas2.upperLayers = arr1;
                canvas2.downLayers = nil;
                canvas2.flatLayers = arr2;
            }
            break;
        case 2:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width/2, frameRect.size.height);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/2, frameRect.size.height);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas1, canvas2, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = arr2;
                canvas1.upperLayers = nil;
                canvas1.downLayers = nil;
                canvas1.flatLayers = arr3;
                
                canvas2.leftLayers = arr1;
                canvas2.rightLayers = nil;
                canvas2.upperLayers = nil;
                canvas2.downLayers = nil;
                canvas2.flatLayers = arr3;                
            }
            break;
        case 3:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width/3, frameRect.size.height);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(frameRect.size.width/3, 0, frameRect.size.width/3, frameRect.size.height);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                canvasRect = CGRectMake(frameRect.size.width*2/3, 0, frameRect.size.width/3, frameRect.size.height);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas1, canvas2, canvas3, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = arr2;
                canvas1.upperLayers = nil;
                canvas1.downLayers = nil;
                canvas1.flatLayers = arr4;
                
                canvas2.leftLayers = arr1;
                canvas2.rightLayers = arr3;
                canvas2.upperLayers = nil;
                canvas2.downLayers = nil;
                canvas2.flatLayers = arr4;
                
                canvas3.leftLayers = arr2;
                canvas3.rightLayers = nil;
                canvas3.upperLayers = nil;
                canvas3.downLayers = nil;
                canvas3.flatLayers = arr4;                
            }
            break;
        case 4:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width/4, frameRect.size.height);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(frameRect.size.width/4, 0, frameRect.size.width/4, frameRect.size.height);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                canvasRect = CGRectMake(frameRect.size.width*2/4, 0, frameRect.size.width/4, frameRect.size.height);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];
           
                canvasRect = CGRectMake(frameRect.size.width*3/4, 0, frameRect.size.width/4, frameRect.size.height);
                CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas4];
                [view addSubview:canvas4];
                [canvas4 release];
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
                NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas1, canvas2, canvas3, canvas4, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = arr2;
                canvas1.upperLayers = nil;
                canvas1.downLayers = nil;
                canvas1.flatLayers = arr5;
                
                canvas2.leftLayers = arr1;
                canvas2.rightLayers = arr3;
                canvas2.upperLayers = nil;
                canvas2.downLayers = nil;
                canvas2.flatLayers = arr5;
                
                canvas3.leftLayers = arr2;
                canvas3.rightLayers = arr4;
                canvas3.upperLayers = nil;
                canvas3.downLayers = nil;
                canvas3.flatLayers = arr5;
                
                canvas4.leftLayers = arr3;
                canvas4.rightLayers = nil;
                canvas4.upperLayers = nil;
                canvas4.downLayers = nil;
                canvas4.flatLayers = arr5;
            }
            break;
        case 5:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width/5, frameRect.size.height);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(frameRect.size.width/5, 0, frameRect.size.width/5, frameRect.size.height);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                canvasRect = CGRectMake(frameRect.size.width*2/5, 0, frameRect.size.width/5, frameRect.size.height);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];
                
                canvasRect = CGRectMake(frameRect.size.width*3/5, 0, frameRect.size.width/5, frameRect.size.height);
                CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas4];
                [view addSubview:canvas4];
                [canvas4 release];
     
                canvasRect = CGRectMake(frameRect.size.width*4/5, 0, frameRect.size.width/5, frameRect.size.height);
                CustomCanvas *canvas5 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas5];
                [view addSubview:canvas5];
                [canvas5 release];
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
                NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas5, nil];
                NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas1, canvas2, canvas3, canvas4, canvas5, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = arr2;
                canvas1.upperLayers = nil;
                canvas1.downLayers = nil;
                canvas1.flatLayers = arr6;
                
                canvas2.leftLayers = arr1;
                canvas2.rightLayers = arr3;
                canvas2.upperLayers = nil;
                canvas2.downLayers = nil;
                canvas2.flatLayers = arr6;
                
                canvas3.leftLayers = arr2;
                canvas3.rightLayers = arr4;
                canvas3.upperLayers = nil;
                canvas3.downLayers = nil;
                canvas3.flatLayers = arr6;

                canvas4.leftLayers = arr3;
                canvas4.rightLayers = arr5;
                canvas4.upperLayers = nil;
                canvas4.downLayers = nil;
                canvas4.flatLayers = arr6;                
                
                canvas5.leftLayers = arr4;
                canvas5.rightLayers = nil;
                canvas5.upperLayers = nil;
                canvas5.downLayers = nil;
                canvas5.flatLayers = arr6;
            }
            break;
        case 6:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width/2, frameRect.size.height/2);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/2, frameRect.size.height/2);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/2, frameRect.size.height);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas1, canvas2, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = arr3;
                canvas1.upperLayers = nil;
                canvas1.downLayers = arr2;
                canvas1.flatLayers = arr1;

                canvas2.leftLayers = nil;
                canvas2.rightLayers = arr3;
                canvas2.upperLayers = arr1;
                canvas2.downLayers = nil;
                canvas2.flatLayers = arr2;
                
                canvas3.leftLayers = arr4;
                canvas3.rightLayers = nil;
                canvas3.upperLayers = nil;
                canvas3.downLayers = nil;
                canvas3.flatLayers = arr3;
            }
            break;
        case 7:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width/2, frameRect.size.height);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/2, frameRect.size.height/2);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                canvasRect = CGRectMake(frameRect.size.width/2, frameRect.size.height/2, frameRect.size.width/2, frameRect.size.height/2);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, canvas3, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas3, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = arr2;
                canvas1.upperLayers = nil;
                canvas1.downLayers = nil;
                canvas1.flatLayers = arr1;
                
                canvas2.leftLayers = arr1;                
                canvas2.rightLayers = nil;
                canvas2.upperLayers = nil;
                canvas2.downLayers = arr4;
                canvas2.flatLayers = arr3;
                
                canvas3.leftLayers = arr1;
                canvas3.rightLayers = nil;
                canvas3.upperLayers = arr3;
                canvas3.downLayers = nil;
                canvas3.flatLayers = arr4;
            }
            break;
        case 8:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width/2, frameRect.size.height/2);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/2, frameRect.size.height/2);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width, frameRect.size.height/2);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas1, canvas2, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = arr2;
                canvas1.upperLayers = nil;
                canvas1.downLayers = arr3;
                canvas1.flatLayers = arr4;
                
                canvas2.leftLayers = arr1;
                canvas2.rightLayers = nil;
                canvas2.upperLayers = nil;
                canvas2.downLayers = arr3;
                canvas2.flatLayers = arr4;
                
                canvas3.leftLayers = nil;
                canvas3.rightLayers = nil;
                canvas3.upperLayers = arr4;
                canvas3.downLayers = nil;
                canvas3.flatLayers = arr3;                
            }
            break;            
        case 9:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height/2);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/2, frameRect.size.height/2);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                canvasRect = CGRectMake(frameRect.size.width/2, frameRect.size.height/2, frameRect.size.width/2, frameRect.size.height/2);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas2, canvas3, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = nil;
                canvas1.upperLayers = nil;
                canvas1.downLayers = arr4;
                canvas1.flatLayers = arr1;

                canvas2.leftLayers = nil;
                canvas2.rightLayers = arr3;
                canvas2.upperLayers = arr1;
                canvas2.downLayers = nil;
                canvas2.flatLayers = arr4;
                
                canvas3.leftLayers = arr2;
                canvas3.rightLayers = nil;
                canvas3.upperLayers = arr1;
                canvas3.downLayers = nil;
                canvas3.flatLayers = arr4;                
            }
            break;
        case 10:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width/3, frameRect.size.height/2);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];            
                
                canvasRect = CGRectMake(frameRect.size.width/3, 0, frameRect.size.width/3, frameRect.size.height/2);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];  
                
                canvasRect = CGRectMake(frameRect.size.width*2/3, 0, frameRect.size.width/3, frameRect.size.height/2);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];  
                
                canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width, frameRect.size.height/2);
                CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas4];
                [view addSubview:canvas4];
                [canvas4 release];
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
                NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas1, canvas2, canvas3, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = arr2;
                canvas1.upperLayers = nil;
                canvas1.downLayers = arr4;
                canvas1.flatLayers = arr5;
                
                canvas2.leftLayers = arr1;
                canvas2.rightLayers = arr3;
                canvas2.upperLayers = nil;
                canvas2.downLayers = arr4;
                canvas2.flatLayers = arr5;
                
                canvas3.leftLayers = arr2;
                canvas3.rightLayers = nil;
                canvas3.upperLayers = nil;
                canvas3.downLayers = arr4;
                canvas3.flatLayers = arr5;
                
                canvas4.leftLayers = nil;
                canvas4.rightLayers = nil;
                canvas4.upperLayers = arr5;
                canvas4.downLayers = nil;
                canvas4.flatLayers = arr4;
            }
            break;
        case 11:
            {
                canvasRect = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height/2);
                CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas1];
                [view addSubview:canvas1];
                [canvas1 release];

                canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
                CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas2];
                [view addSubview:canvas2];
                [canvas2 release];            
                
                canvasRect = CGRectMake(frameRect.size.width/3, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
                CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas3];
                [view addSubview:canvas3];
                [canvas3 release];  
                
                canvasRect = CGRectMake(frameRect.size.width*2/3, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
                CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
                [canvasArray addObject:canvas4];
                [view addSubview:canvas4];
                [canvas4 release];  
                
                
                NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
                NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
                NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
                NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
                NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas2, canvas3, canvas4, nil];
                
                canvas1.leftLayers = nil;
                canvas1.rightLayers = nil;
                canvas1.upperLayers = nil;
                canvas1.downLayers = arr5;
                canvas1.flatLayers = arr1;
                
                canvas2.leftLayers = nil;
                canvas2.rightLayers = arr3;
                canvas2.upperLayers = arr1;
                canvas2.downLayers = nil;
                canvas2.flatLayers = arr5;

                canvas3.leftLayers = arr2;                
                canvas3.rightLayers = arr4;
                canvas3.upperLayers = arr1;
                canvas3.downLayers = nil;
                canvas3.flatLayers = arr5;
                
                canvas4.leftLayers = arr3;                
                canvas4.rightLayers = nil;
                canvas4.upperLayers = arr1;
                canvas4.downLayers = nil;
                canvas4.flatLayers = arr5;                
        }
        break;
     case 12:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/2, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];
            
            canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/2, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];            
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/2, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];  
            
            canvasRect = CGRectMake(frameRect.size.width/2, frameRect.size.height/2, frameRect.size.width/2, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas1, canvas2, nil];
            NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas3, canvas4, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr2;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr6;
            canvas1.flatLayers = arr5;
            
            canvas2.leftLayers = arr1;
            canvas2.rightLayers = nil;
            canvas2.upperLayers = nil;
            canvas2.downLayers = arr6;
            canvas2.flatLayers = arr5;
            
            canvas3.leftLayers = nil;
            canvas3.rightLayers = arr4;
            canvas3.upperLayers = arr5;
            canvas3.downLayers = nil;
            canvas3.flatLayers = arr6;            
            
            canvas4.leftLayers = arr3;
            canvas4.rightLayers = nil;
            canvas4.upperLayers = arr5;
            canvas4.downLayers = nil;
            canvas4.flatLayers = arr6;            
        }
        break;
   case 13:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/3, frameRect.size.height);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];
            
            canvasRect = CGRectMake(frameRect.size.width/3, 0, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];            
            
            canvasRect = CGRectMake(frameRect.size.width/3, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*2/3, 0, frameRect.size.width/3, frameRect.size.height);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas2, canvas3, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr5;
            canvas1.upperLayers = nil;
            canvas1.downLayers = nil;
            canvas1.flatLayers = arr1;
            
            canvas2.leftLayers = arr1;
            canvas2.rightLayers = arr4;
            canvas2.upperLayers = nil;
            canvas2.downLayers = arr3;
            canvas2.flatLayers = arr2;
            
            canvas3.leftLayers = arr1;
            canvas3.rightLayers = arr4;
            canvas3.upperLayers = arr2;
            canvas3.downLayers = nil;
            canvas3.flatLayers = arr3;            
            
            canvas4.leftLayers = arr5;            
            canvas4.rightLayers = nil;
            canvas4.upperLayers = nil;
            canvas4.downLayers = nil;
            canvas4.flatLayers = arr4;    
        }
        break;
        case 14:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/2, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/2, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];            
            
            canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/4, frameRect.size.height);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*3/4, 0, frameRect.size.width/4, frameRect.size.height);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas1, canvas2, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr3;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr2;
            canvas1.flatLayers = arr1;
            
            canvas2.leftLayers = nil;
            canvas2.rightLayers = arr3;
            canvas2.upperLayers = arr1;
            canvas2.downLayers = nil;
            canvas2.flatLayers = arr2;

            canvas3.leftLayers = arr5;            
            canvas3.rightLayers = arr4;
            canvas3.upperLayers = nil;
            canvas3.downLayers = nil;
            canvas3.flatLayers = arr3;            
            
            canvas4.leftLayers = arr3;
            canvas4.rightLayers = nil;
            canvas4.upperLayers = nil;
            canvas4.downLayers = nil;
            canvas4.flatLayers = arr4;    
        }
            break;
        case 15:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/4, frameRect.size.height);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];
            
            canvasRect = CGRectMake(frameRect.size.width/4, 0, frameRect.size.width/4, frameRect.size.height);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];            
            
            canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/2, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];  
            
            canvasRect = CGRectMake(frameRect.size.width/2, frameRect.size.height/2, frameRect.size.width/2, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas3, canvas4, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr2;
            canvas1.upperLayers = nil;
            canvas1.downLayers = nil;
            canvas1.flatLayers = arr1;
            
            canvas2.leftLayers = arr1;
            canvas2.rightLayers = arr5;
            canvas2.upperLayers = nil;
            canvas2.downLayers = nil;
            canvas2.flatLayers = arr2;
            
            canvas3.leftLayers = arr2;
            canvas3.rightLayers = nil;
            canvas3.upperLayers = nil;
            canvas3.downLayers = arr4;
            canvas3.flatLayers = arr3;            
            
            canvas4.leftLayers = arr2;
            canvas4.rightLayers = nil;
            canvas4.upperLayers = arr3;
            canvas4.downLayers = nil;
            canvas4.flatLayers = arr4;    
        }
            break;
        case 16:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];
            
            canvasRect = CGRectMake(frameRect.size.width/4, 0, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];            
            
            canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*3/4, 0, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width, frameRect.size.height/2);
            CustomCanvas *canvas5 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas5];
            [view addSubview:canvas5];
            [canvas5 release];  
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas5, nil];            
            NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas1, canvas2, canvas3, canvas4, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr2;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr5;
            canvas1.flatLayers = arr6;
            
            canvas2.leftLayers = arr1;
            canvas2.rightLayers = arr3;
            canvas2.upperLayers = nil;
            canvas2.downLayers = arr5;
            canvas2.flatLayers = arr6;
            
            canvas3.leftLayers = arr2;
            canvas3.rightLayers = arr4;
            canvas3.upperLayers = nil;
            canvas3.downLayers = arr5;
            canvas3.flatLayers = arr6;            
            
            canvas4.leftLayers = arr3;
            canvas4.rightLayers = nil;
            canvas4.upperLayers = nil;
            canvas4.downLayers = arr5;
            canvas4.flatLayers = arr6;    
            
            canvas5.leftLayers = nil;
            canvas5.rightLayers = nil;
            canvas5.upperLayers = arr6;
            canvas5.downLayers = nil;
            canvas5.flatLayers = arr5;    
        }
            break;
        case 17:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];  
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];
            
            canvasRect = CGRectMake(frameRect.size.width/4, frameRect.size.height/2, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];            
            
            canvasRect = CGRectMake(frameRect.size.width/2, frameRect.size.height/2, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*3/4, frameRect.size.height/2, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas5 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas5];
            [view addSubview:canvas5];
            [canvas5 release];  
            
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas5, nil];            
            NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas2, canvas3, canvas4, canvas5, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = nil;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr6;
            canvas1.flatLayers = arr1;

            canvas2.leftLayers = nil;            
            canvas2.rightLayers = arr3;
            canvas2.upperLayers = arr1;
            canvas2.downLayers = nil;
            canvas2.flatLayers = arr6;
            
            canvas3.leftLayers = arr2;            
            canvas3.rightLayers = arr4;
            canvas3.upperLayers = arr1;
            canvas3.downLayers = nil;
            canvas3.flatLayers = arr6;            
            
            canvas4.leftLayers = arr3;
            canvas4.rightLayers = arr5;
            canvas4.upperLayers = arr1;
            canvas4.downLayers = nil;
            canvas4.flatLayers = arr6;    
            
            canvas5.leftLayers = arr4;
            canvas5.rightLayers = nil;
            canvas5.upperLayers = arr1;
            canvas5.downLayers = nil;
            canvas5.flatLayers = arr6;    
        }
            break;   
        case 18:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];
            
            canvasRect = CGRectMake(frameRect.size.width/5, 0, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];            
            
            canvasRect = CGRectMake(frameRect.size.width*2/5, 0, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*3/5, 0, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*4/5, 0, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas5 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas5];
            [view addSubview:canvas5];
            [canvas5 release];  
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width, frameRect.size.height/2);
            CustomCanvas *canvas6 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas6];
            [view addSubview:canvas6];
            [canvas6 release];  
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas5, nil];            
            NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas6, nil];
            NSMutableArray *arr7 = [NSMutableArray arrayWithObjects:canvas1, canvas2, canvas3, canvas4, canvas5, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr2;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr6;
            canvas1.flatLayers = arr7;
            
            canvas2.leftLayers = arr1;
            canvas2.rightLayers = arr3;
            canvas2.upperLayers = nil;
            canvas2.downLayers = arr6;
            canvas2.flatLayers = arr7;
            
            canvas3.leftLayers = arr2;
            canvas3.rightLayers = arr4;
            canvas3.upperLayers = nil;
            canvas3.downLayers = arr6;
            canvas3.flatLayers = arr7;            
            
            canvas4.leftLayers = arr3;
            canvas4.rightLayers = arr5;
            canvas4.upperLayers = nil;
            canvas4.downLayers = arr6;
            canvas4.flatLayers = arr7;    
            
            canvas5.leftLayers = arr4;
            canvas5.rightLayers = nil;
            canvas5.upperLayers = nil;
            canvas5.downLayers = arr6;
            canvas5.flatLayers = arr7;
            
            canvas6.leftLayers = nil;
            canvas6.rightLayers = nil;
            canvas6.upperLayers = arr7;
            canvas6.downLayers = nil;
            canvas6.flatLayers = arr6;
        }
            break;
        case 19:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];  
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];
            
            canvasRect = CGRectMake(frameRect.size.width/5, frameRect.size.height/2, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];            
            
            canvasRect = CGRectMake(frameRect.size.width*2/5, frameRect.size.height/2, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*3/5, frameRect.size.height/2, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas5 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas5];
            [view addSubview:canvas5];
            [canvas5 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*4/5, frameRect.size.height/2, frameRect.size.width/5, frameRect.size.height/2);
            CustomCanvas *canvas6 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas6];
            [view addSubview:canvas6];
            [canvas6 release];  
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas5, nil];            
            NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas6, nil];            
            NSMutableArray *arr7 = [NSMutableArray arrayWithObjects:canvas2, canvas3, canvas4, canvas5, canvas6, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = nil;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr7;
            canvas1.flatLayers = arr1;
            
            canvas2.leftLayers = nil;
            canvas2.rightLayers = arr3;
            canvas2.upperLayers = arr1;
            canvas2.downLayers = nil;
            canvas2.flatLayers = arr7;
            
            canvas3.leftLayers = arr2;
            canvas3.rightLayers = arr4;
            canvas3.upperLayers = arr1;
            canvas3.downLayers = nil;
            canvas3.flatLayers = arr7;            
            
            canvas4.leftLayers = arr3;
            canvas4.rightLayers = arr5;
            canvas4.upperLayers = arr1;
            canvas4.downLayers = nil;
            canvas4.flatLayers = arr7;    
            
            canvas5.leftLayers = arr4;
            canvas5.rightLayers = arr6;
            canvas5.upperLayers = arr1;
            canvas5.downLayers = nil;
            canvas5.flatLayers = arr7;    

            canvas6.leftLayers = arr5;
            canvas6.rightLayers = nil;
            canvas6.upperLayers = arr1;
            canvas6.downLayers = nil;
            canvas6.flatLayers = arr7;    
        }
            break; 
        case 20:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];  
            
            canvasRect = CGRectMake(frameRect.size.width/4, 0, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];
            
            canvasRect = CGRectMake(frameRect.size.width/2, 0, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];            
            
            canvasRect = CGRectMake(frameRect.size.width*3/4, 0, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas5 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas5];
            [view addSubview:canvas5];
            [canvas5 release];  
            
            canvasRect = CGRectMake(frameRect.size.width/3, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas6 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas6];
            [view addSubview:canvas6];
            [canvas6 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*2/3, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas7 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas7];
            [view addSubview:canvas7];
            [canvas7 release];  
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas5, nil];            
            NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas6, nil];            
            NSMutableArray *arr7 = [NSMutableArray arrayWithObjects:canvas7, nil]; 
            NSMutableArray *arr8 = [NSMutableArray arrayWithObjects:canvas1, canvas2, canvas3, canvas4, nil];
            NSMutableArray *arr9 = [NSMutableArray arrayWithObjects:canvas5, canvas6, canvas7, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr2;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr9;
            canvas1.flatLayers = arr8;
            
            canvas2.leftLayers = arr1;
            canvas2.rightLayers = arr3;
            canvas2.upperLayers = nil;
            canvas2.downLayers = arr9;
            canvas2.flatLayers = arr8;
            
            canvas3.leftLayers = arr2;
            canvas3.rightLayers = arr4;
            canvas3.upperLayers = nil;
            canvas3.downLayers = arr9;
            canvas3.flatLayers = arr8;            
            
            canvas4.leftLayers = arr3;
            canvas4.rightLayers = nil;
            canvas4.upperLayers = nil;
            canvas4.downLayers = arr9;
            canvas4.flatLayers = arr8;    
            
            canvas5.leftLayers = nil;
            canvas5.rightLayers = arr6;
            canvas5.upperLayers = arr8;
            canvas5.downLayers = nil;
            canvas5.flatLayers = arr9;    

            canvas6.leftLayers = arr5;            
            canvas6.rightLayers = arr7;
            canvas6.upperLayers = arr8;
            canvas6.downLayers = nil;
            canvas6.flatLayers = arr9;    

            canvas7.leftLayers = arr6;
            canvas7.rightLayers = nil;
            canvas7.upperLayers = arr8;
            canvas7.downLayers = nil;
            canvas7.flatLayers = arr9;    

        }
            break;             
        case 21:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];  
            
            canvasRect = CGRectMake(frameRect.size.width/3, 0, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];
            
            canvasRect = CGRectMake(frameRect.size.width*2/3, 0, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];            
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            canvasRect = CGRectMake(frameRect.size.width/4, frameRect.size.height/2, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas5 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas5];
            [view addSubview:canvas5];
            [canvas5 release];  
            
            canvasRect = CGRectMake(frameRect.size.width/2, frameRect.size.height/2, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas6 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas6];
            [view addSubview:canvas6];
            [canvas6 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*3/4, frameRect.size.height/2, frameRect.size.width/4, frameRect.size.height/2);
            CustomCanvas *canvas7 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas7];
            [view addSubview:canvas7];
            [canvas7 release];  
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas5, nil];            
            NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas6, nil];            
            NSMutableArray *arr7 = [NSMutableArray arrayWithObjects:canvas7, nil]; 
            NSMutableArray *arr8 = [NSMutableArray arrayWithObjects:canvas1, canvas2, canvas3, nil];
            NSMutableArray *arr9 = [NSMutableArray arrayWithObjects:canvas4, canvas5, canvas6, canvas7, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr2;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr9;
            canvas1.flatLayers = arr8;

            canvas2.leftLayers = arr1;            
            canvas2.rightLayers = arr3;
            canvas2.upperLayers = nil;
            canvas2.downLayers = arr9;
            canvas2.flatLayers = arr8;
            
            canvas3.leftLayers = arr2;
            canvas3.rightLayers = nil;
            canvas3.upperLayers = nil;
            canvas3.downLayers = arr9;
            canvas3.flatLayers = arr8;            
            
            canvas4.leftLayers = nil;
            canvas4.rightLayers = arr5;
            canvas4.upperLayers = arr8;
            canvas4.downLayers = nil;
            canvas4.flatLayers = arr9;    
            
            canvas5.leftLayers = arr4;
            canvas5.rightLayers = arr6;
            canvas5.upperLayers = arr8;
            canvas5.downLayers = nil;
            canvas5.flatLayers = arr9;    
            
            canvas6.leftLayers = arr5;
            canvas6.rightLayers = arr7;
            canvas6.upperLayers = arr8;
            canvas6.downLayers = nil;
            canvas6.flatLayers = arr9;    
            
            canvas7.leftLayers = nil;
            canvas7.rightLayers = nil;
            canvas7.upperLayers = arr8;
            canvas7.downLayers = nil;
            canvas7.flatLayers = arr9;    
        }
            break;  
        case 22:
        {
            canvasRect = CGRectMake(0, 0, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas1 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas1];
            [view addSubview:canvas1];
            [canvas1 release];  
            
            canvasRect = CGRectMake(0, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas2 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas2];
            [view addSubview:canvas2];
            [canvas2 release];
            
            canvasRect = CGRectMake(frameRect.size.width/3, 0, frameRect.size.width/3, frameRect.size.height);
            CustomCanvas *canvas3 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas3];
            [view addSubview:canvas3];
            [canvas3 release];            
            
            canvasRect = CGRectMake(frameRect.size.width*2/3, 0, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas4 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas4];
            [view addSubview:canvas4];
            [canvas4 release];  
            
            canvasRect = CGRectMake(frameRect.size.width*2/3, frameRect.size.height/2, frameRect.size.width/3, frameRect.size.height/2);
            CustomCanvas *canvas5 = (CustomCanvas*)[[CustomCanvas alloc] initWithFrame:canvasRect];
            [canvasArray addObject:canvas5];
            [view addSubview:canvas5];
            [canvas5 release];  
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:canvas1, nil];
            NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:canvas2, nil];
            NSMutableArray *arr3 = [NSMutableArray arrayWithObjects:canvas3, nil];
            NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:canvas4, nil];
            NSMutableArray *arr5 = [NSMutableArray arrayWithObjects:canvas5, nil];            
            NSMutableArray *arr6 = [NSMutableArray arrayWithObjects:canvas1, canvas2, nil];
            NSMutableArray *arr7 = [NSMutableArray arrayWithObjects:canvas4, canvas5, nil];
            
            canvas1.leftLayers = nil;
            canvas1.rightLayers = arr3;
            canvas1.upperLayers = nil;
            canvas1.downLayers = arr2;
            canvas1.flatLayers = arr1;
            
            canvas2.leftLayers = nil;
            canvas2.rightLayers = arr3;
            canvas2.upperLayers = arr1;
            canvas2.downLayers = nil;
            canvas2.flatLayers = arr2;
            
            canvas3.leftLayers = arr6;
            canvas3.rightLayers = arr7;
            canvas3.upperLayers = nil;
            canvas3.downLayers = nil;
            canvas3.flatLayers = arr3;            
            
            canvas4.leftLayers = arr3;
            canvas4.rightLayers = nil;
            canvas4.upperLayers = nil;
            canvas4.downLayers = arr5;
            canvas4.flatLayers = arr4;    
            
            canvas5.leftLayers = arr3;
            canvas5.rightLayers = nil;
            canvas5.upperLayers = arr4;
            canvas5.downLayers = nil;
            canvas5.flatLayers = arr5;    
        }
            break;  

        default:
            break;
    }
    
    return canvasArray;
}
@end
