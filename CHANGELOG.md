# Changelog  
All notable changes to this project will be documented in this file.  
  
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) featuring Added, Changed, Deprecated,
Removed, Fixed, Security, and others; and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.3] - 2022-01-09
### Fixed
- Fixes [issue 1](https://github.com/damian-m-g/xlsx_drone_rb/issues/1). 

## [0.4.2] - 2021-11-28
### Fixed
- xlsx_drone core library (C) was updated from 0.2.2 to 0.2.3 fixing one issue. Mirroring those changes here through updating the dlls.

## [0.4.1] - 2021-10-21
### Fixed
- xlsx_drone core library (C) was updated from 0.2.0 to 0.2.2 fixing a few problems. Mirroring those changes here through updating the dlls.

## [0.4.0] - 2021-01-16
### Added
- Method Sheet#last_column().
- Method Sheet#empty?().
- Several test assertions for new functionality.
- Using new xlsx_drone version (0.2.0).

## [0.3.0] - 2021-01-12
### Added
- A benchmark comparison against other xlsx reading libraries.
- Several new assertions.
- Although the OS will claim memory gathered from malloc at program termination, it's a good practice to free this
allocated memory manually. This is why a new hook method will be called at program -in terms- termination:
XLSXDrone::Workbook.close_workbooks().
  
### Changed
- The error reporting system from the C's library was updated, so had to be the Ruby one. Those changes were reflected.
- The XLSXDrone::Workbook#load_sheet() method is safer now. Will raise an exception if ANY problem arises, instead of
returning nil. This means, it will never return nil. It will return a valid XLSXDrone::Sheet object or will raise an
exception.
- If the user tries to use a workbook already closed, an exception will get raised explaining the situation, no more
segfaults.
  
### Fixed
- The native binding was improved to work well with x64.
- UTF-8 strings now are successfully read!
- Fixed several problems with date, time & date time Excel values.

## [0.2.0] - 2019-04-05
### Added
- Method XLSXDrone::Sheet#name(). Returns the sheet name as a #String.

## [0.1.0] - 2019-02-05  
### Added  
- Pristine version.
