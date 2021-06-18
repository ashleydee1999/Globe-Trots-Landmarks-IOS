import SwiftUI
import MapKit

struct MapView: View
{
    @Binding var lat: Double
    @Binding var lon: Double
    
    private let initialLatitudinalMeters: Double = 100
    private let initialLongitudinalMeters: Double = 100
    
    @State private var span: MKCoordinateSpan?
  
    init(lat: Binding<Double>, lon: Binding<Double>)
      {
        _lat = lat
        _lon = lon
      }
    
    private var region : Binding<MKCoordinateRegion>
    {
        Binding
        {
            let centre = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            if let span = span
            {
               
                return MKCoordinateRegion(center: centre, span: span)
            }
            else
            {
                return MKCoordinateRegion(center: centre, latitudinalMeters: initialLatitudinalMeters,longitudinalMeters: initialLongitudinalMeters)
            }
        }
        set:
        {
            region in
            lat = region.center.latitude
            lon = region.center.longitude
            span = region.span
            
        }
        
    }

    var body: some View {
        Map(coordinateRegion: region)
    }
}


struct MapView_Previews: PreviewProvider
{
    
    static var previews: some View
    {
        MapView(lat: .constant(33.9328), lon: .constant(18.8644))
    }
}
