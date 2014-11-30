//
//  main.m
//  TicTacToe
//
//  Created by Nelly Santoso on 11/29/14.
//  Copyright (c) 2014 Nelly Santoso. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // finding out the name of player one and player two
        NSLog(@"\nPlayer 1 \nPlease enter your name:");
        NSFileHandle *player1 = [NSFileHandle fileHandleWithStandardInput];
        NSData *player1_name = [player1 availableData];
        
        NSString *str_player1 = [[NSString alloc] initWithData:player1_name encoding:NSUTF8StringEncoding];
        printf("Welcome %s", [str_player1 UTF8String]);
        printf("Your icon is O\n");

        printf("\nPlayer 2 \nPlease enter your name:");
        NSFileHandle *player2 = [NSFileHandle fileHandleWithStandardInput];
        NSData *player2_name = [player2 availableData];
        
        NSString *str_player2 = [[NSString alloc] initWithData:player2_name encoding:NSUTF8StringEncoding];
        printf("Welcome %s", [str_player2 UTF8String]);
        printf("Your icon is X\n\n");
        printf("Let's play tic tac toe game!\n");
        printf("Rule: The player who succeeds in placing three respective marks in a horizontal, vertical, or diagonal row wins the game.\n");
        printf("Here is the table\n");
        printf("-------------\n| A | B | C |\n-------------\n| D | E | F |\n-------------\n| G | H | I |\n-------------\n");
        printf("it's your turn, %s!",[str_player1 UTF8String]);
        NSFileHandle *player1_data = [NSFileHandle fileHandleWithStandardInput];
        NSData *player1_moves = [player1_data availableData];
        NSString *move_player1 = [[NSString alloc] initWithData:player1_moves encoding:NSUTF8StringEncoding];
        
        NSDictionary *default_table = @{@1:@"A",@2:@"B",@3:@"C",@4:@"D",@5:@"E",@6:@"F",@7:@"G",@8:@"H",@9:@"I"};
        NSMutableDictionary *table_score = [NSMutableDictionary dictionaryWithDictionary:default_table];
        NSMutableArray *player1_score = [[NSMutableArray alloc]init];
//        NSMutableArray *player2_score = [[NSMutableArray alloc]init];
        [player1_score addObject:move_player1];
        
        [table_score setObject:@"O" forKey:@1];
        [table_score setObject:@"X" forKey:@2];
        
//        NSLog(@"%@", default_table);
        NSLog(@"%@", table_score);
        
        
    }
    return 0;
}
