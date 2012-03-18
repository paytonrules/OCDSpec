@class OCDSpecSharedResults;
@protocol DescriptionRunner

+(OCDSpecSharedResults *) run;
+(int) getSuccesses;
+(int) getFailures;

@end
