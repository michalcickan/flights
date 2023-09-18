extension Client {
    public func fetchPlacesNodes(params: PlacesQueryParameters) async throws -> Places {
        try await fetch(
            query: RootQuery(
                places: PlacesQuery(
                    parameters: params,
                    body: PlacesQuery.Body(
                        placeConnection: OnPlaceConnectionQuery(
                            body: OnPlaceConnectionQuery.Body(
                                edges: EdgesQuery(
                                    body: EdgesQuery.Body(
                                        node: NodeQuery(
                                            body: NodeQuery.Body(
                                                id: "",
                                                legacyId: "",
                                                gps: GPSQuery(
                                                    body: GPSQuery.Body(
                                                        lng: "",
                                                        lat: ""
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),
            queryName: "getPlaces"
        ).places
    }
}
