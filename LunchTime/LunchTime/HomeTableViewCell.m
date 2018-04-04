//
//  HomeTableViewCell.m
//  LunchTime
//
//  Created by Guxiaojie on 05/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell()
@property(strong,nonatomic) UIImageView *leftColorView;
@property(strong,nonatomic) UILabel *nameLabel;
@property(strong,nonatomic) UILabel *descriptionLabel;
@property(strong,nonatomic) UIButton *goButton;
@end

//image size
static const CGFloat leftColorViewWidth = 50;
//font size
static const CGFloat textFontSize = 14;

@implementation HomeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //background
        self.backgroundColor = RGB(255, 255, 255);
        self.accessoryType = UITableViewCellAccessoryNone;
        
        if (self.leftColorView == nil) {
            self.leftColorView = [[UIImageView alloc] init];
            self.leftColorView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.1];
            [self.contentView addSubview:self.leftColorView];
            [self.leftColorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView.mas_left).with.offset(15);
                make.top.mas_equalTo(self.contentView.mas_top).with.offset(15);
                make.width.mas_equalTo(leftColorViewWidth);
                make.height.mas_equalTo(leftColorViewWidth);
            }];
        }
        
        if (self.nameLabel == nil) {
            self.nameLabel = [[UILabel alloc] init];
            self.nameLabel.font = CHINESE_SYSTEM(textFontSize);
            self.nameLabel.textColor = [UIColor grayColor];
            self.nameLabel.textAlignment = NSTextAlignmentLeft;
            self.nameLabel.numberOfLines = 0;
            [self.nameLabel sizeToFit];
            [self.contentView addSubview:self.nameLabel];
            [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView.mas_top).with.offset(15);
                make.left.mas_equalTo(self.leftColorView.mas_right).with.offset(15);
                make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
            }];
        }
        
        if (self.descriptionLabel == nil) {
            self.descriptionLabel = [[UILabel alloc] init];
            self.descriptionLabel.font = CHINESE_SYSTEM(textFontSize);
            self.descriptionLabel.textColor = [UIColor grayColor];
            self.descriptionLabel.textAlignment = NSTextAlignmentLeft;
            self.descriptionLabel.numberOfLines = 0;
            [self.descriptionLabel sizeToFit];
            [self.contentView addSubview:self.descriptionLabel];
            [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(15);
                make.left.mas_equalTo(self.leftColorView.mas_right).with.offset(15);
                make.right.mas_equalTo(self.contentView.mas_right).with.offset(-15);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-15);
            }];
        }
        
        
        //直接绑定  这边有个注意Racobserve 左边只有self  右边才有viewModel.building_name  这样就避CELL 重用的问题
        RAC(self.nameLabel,text) = RACObserve(self, viewModel.title);
        RAC(self.descriptionLabel,text) = RACObserve(self, viewModel.descrip);
        RACSignal *imageData = RACObserve(self, viewModel.img);
        RAC(self.leftColorView, highlightedImage) =  [imageData map:^id(id value) {
            if (value != nil) {
                [self.leftColorView sd_setImageWithURL:[NSURL URLWithString: value] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    self.leftColorView.image = image;
                }];
            }
            return nil;
        }];
        
        [[[self.goButton
           rac_signalForControlEvents:UIControlEventTouchUpInside]
          takeUntil:self.rac_prepareForReuseSignal]
         subscribeNext:^(id x) {
             NSLog(@"cell 跳转");
         }];
        
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
