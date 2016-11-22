//
//  CDSNoOp.swift
//  ChainableDataSource
//

import Foundation

public class CDSNoOp: CDSTransform {
    
    public override func cds_numberOfSections() -> Int {
        guard let sectionCount = dataSourceCaches.first?.sectionsObjectCounts else { return 0 }
        return min(sectionCount.count, 1);
    }
    
    public override func cds_numberOfObjects(inSection section: Int) -> Int {
        guard let firstDataSourceCache = dataSourceCaches.first,
            firstDataSourceCache.sectionsObjectCounts.count > 0,
            section == 0
            else { return 0 }
        
        return firstDataSourceCache.sectionsObjectCounts[0].intValue;
    }
    
    public override func sourceIndexPath(for indexPath: IndexPath!) -> IndexPath! {
        guard let firstDataSourceCache = dataSourceCaches.first,
            firstDataSourceCache.sectionsObjectCounts.count > 0,
            indexPath.section == 0
            else { return nil }
        
        return NSIndexPath.cds_indexPath(forObject:indexPath.row , inSection: indexPath.section, inDataSource: 0)
    }
    
    public override func indexPath(forSourceIndexPath sourceIndexPath: IndexPath!, in sourceDataSource: CDSDataSourceProtocol!) -> IndexPath! {
        guard dataSource != nil,
            (sourceDataSource as! NSObject).isEqual(dataSource as! NSObject),
        sourceIndexPath.section == 0
        else { return nil }
        
        return sourceIndexPath;
    }
    
    public override func sectionIndex(forSourceSectionIndex sourceSection: Int, in sourceDataSource: CDSDataSourceProtocol!) -> Int {
        guard dataSource != nil,
            (sourceDataSource as! NSObject).isEqual(dataSource as! NSObject),
            sourceSection == 0 else { return NSNotFound }
        return sourceSection;
    }
    
    public override func sourceSectionIndexPath(forSectionIndex section: Int) -> IndexPath! {
        guard let firstDataSourceCache = dataSourceCaches.first,
            firstDataSourceCache.sectionsObjectCounts.count > 0 else {
            return nil
        }
        return NSIndexPath.cds_indexPath(forSection: 0, inDataSource: 0)
    }
}
