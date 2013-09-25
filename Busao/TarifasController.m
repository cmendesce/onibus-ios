//
//  TarifasController.m
//  BusaoFortal
//
//  Created by Carlos Mendes on 24/09/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "TarifasController.h"

@interface TarifasController ()

@property (nonatomic, strong) NSArray *tarifas;
@property (nonatomic, strong) NSNumberFormatter *formatter;

@end

@implementation TarifasController

-(id)init {
    self = [super init];
    if (self) {
        UITabBarItem *listaItem = [[UITabBarItem alloc] initWithTitle:NSLocalized(@"tarifas") image:[UIImage imageNamed:@"088-Map.png"] tag:1];
        
        self.tabBarItem = listaItem;
        self.navigationItem.title = NSLocalized(@"tarifas");
    }
    return self;
}

-(NSArray *)tarifas
{
    if (!_tarifas) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tarifas" ofType:@"json"];
        
        NSData *bytes = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData: bytes options:kNilOptions error:nil];
        
        _tarifas = json[@"tarifas"];
    }
    return _tarifas;
}

-(NSNumberFormatter *)formatter
{
    if (!_formatter) {
        _formatter = [[NSNumberFormatter alloc] init];
        [_formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    }
    return _formatter;
}

#pragma - mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tarifas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *tarifa = self.tarifas[indexPath.row];
    
    cell.textLabel.text = tarifa[@"descricao"];
    cell.detailTextLabel.text = [self tarifaInteira:tarifa[@"valorInteira"] eMeia:tarifa[@"valorMeia"]];
    
    return cell;
}

-(NSString *)tarifaInteira: (NSString *)inteira eMeia: (NSString *)meia
{
    inteira = [self.formatter stringFromNumber:@(inteira.floatValue)];
    meia = [self.formatter stringFromNumber:@(meia.floatValue)];
    
    NSString *vlr = [NSString stringWithFormat:@"%@ (%@) %@ (%@)", inteira, NSLocalized(@"inteira"), meia, NSLocalized(@"meia")];
    
    return vlr;
}
                         
@end






























