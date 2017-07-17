//
//  ViewController.m
//  ZJArchive
//
//  Created by ad on 17/7/17.
//  Copyright © 2017年 zjhcsoftios. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/// 数据源
@property (nonatomic,strong) NSMutableArray *persons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"归档解档";
    self.tableView.rowHeight = 50;
    [self UnArchiveBtnClick];
}

- (NSMutableArray *)persons{
    if (!_persons) {
        _persons = [NSMutableArray new];
    }
    return _persons;
}

// 归档
- (IBAction)ArchiveBtnClick:(id)sender {
    BOOL isSuccess = NO;
    isSuccess = [NSKeyedArchiver archiveRootObject:self.persons toFile:[self filePath]];
    if (isSuccess) {
        NSLog(@"Success");
    }else{
        NSLog(@"False");
    }
}

// 存放路径
- (NSString *)filePath{
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    stringPath = [stringPath stringByAppendingPathComponent:@"person.plist"];
    return stringPath;
}

// 解档
- (void)UnArchiveBtnClick {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePath]]) {
        self.persons = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    }
    [self.tableView reloadData];
}

// 添加数据
- (IBAction)AddPerson:(id)sender {
    Person *person = [[Person alloc] init];
    int age = arc4random() % 70;
    person.name = [NSString stringWithFormat:@"zj--%d",age];
    person.age = age;
    person.height = arc4random() % 200;
    [self.persons addObject:person];
    [self.tableView reloadData];
}


#pragma mark tableview 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellId"];
    Person *person = self.persons[indexPath.row];
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"年龄：%d 身高：%d",person.age,person.height];
    return cell;
}

@end
