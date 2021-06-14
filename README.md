# NASA Image Viewer

## Architecture

- MVVM with Combine

## Design Patterns & Principles

- Applied the factory method pattern for creating endpoint URLs
- SOLID principles
    - Singles responsibility: view controllers and other types have a single responsibility
    - Interface Segregation: interfaces (protocols) where kept small and and callers only need to implement what is needed
    - Dependency Inversion: where possible protocols was used over concrete implementation which also improves testability 
- Readability: where possible I tried to design the APIs with readability in mind making use of structs, tuples, enums and associated values

## Best Practices

- Long running, asynchronous tasks does not block the main application queue to keep the UI responsive
- The UI was designed with light & dark mode in mind and supports both

## Added Improvements

- Added a discloser indicator to table the view cells since they show secondary information to the user
- A place holder images was introduced while images are being downloaded in the background

## Additional Notes

- Further improvement to the image list view can done when caching the downloaded images. This will greatly improve scrolling performance as well as the user experience. For this I will use a library like [Kingfisher](https://github.com/onevcat/Kingfisher)
