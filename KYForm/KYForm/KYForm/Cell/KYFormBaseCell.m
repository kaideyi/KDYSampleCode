//
//  KYFormBaseCell.m
//  KYForm
//
//  Created by mac on 2017/12/20.
//

#import "KYFormBaseCell.h"
#import "UIColor+Extensions.h"
#import "Tools.h"

@implementation KYFormBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    
    return self;
}

- (void)setupView {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.textLabel.textColor = [UIColor black33];
    self.detailTextLabel.textColor = [UIColor black95];
    self.textLabel.font = Font(15);
    self.detailTextLabel.font = Font(14);
}

- (void)configure {
}

- (void)setRowModel:(FormRowModel *)rowModel {
    _rowModel = rowModel;
    
    self.textLabel.text = rowModel.title;
    self.detailTextLabel.text = rowModel.tip;
}

@end