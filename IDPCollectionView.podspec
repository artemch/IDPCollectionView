Pod::Spec.new do |s|
	s.name					= 'IDPCollectionView'
	s.version				= '1.0'
	s.summary				= 'IDPCollectionView'
	s.homepage			= 'https://github.com/artemch/IDPCollectionView'
	s.license				= 'MIT'
	s.author				= { 'Artem Chabannyi' => 'artem.chabanniy@gmail.com' }
	s.source				= { :git => 'https://github.com/artemch/IDPCollectionView.git', :tag => s.version.to_s }
	s.platform			= :osx, '10.8'
	s.source_files	= 'src/**/*.{h,m}'
	s.frameworks		= 'Cocoa', 'QuartzCore'
	s.requires_arc	= true
end
