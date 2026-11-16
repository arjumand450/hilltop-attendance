# Decision Log: Provider vs Riverpod

## Decision
I chose Provider for state management in the Hilltop Guest House Staff Attendance app.

## Context
The app needs one shared piece of state for now: who is logged in. The login checks a static JSON file, and I am still learning Flutter. The app is small, so I wanted the simplest tool that works.

## Comparison

| Area | Provider | Riverpod |
|------|----------|----------|
| Learning curve | Easy, built on basic Flutter ideas like InheritedWidget and ChangeNotifier | Steeper, has more concepts such as different provider types and refs |
| Boilerplate | Very little for small apps | A bit more setup |
| Compile-time safety | A missing provider is only found at runtime | Catches many of these errors at compile time |
| Testing | Good, but often needs a widget tree | Easier, providers can be tested without widgets |
| Community and docs | Large, many tutorials | Growing fast, modern |
| Scaling to big apps | Gets harder with many dependent providers | Handles large apps and dependencies better |

## Pros and cons of my choice

| Pros | Cons |
|------|------|
| Simple and quick to set up | Harder to manage if many providers depend on each other |
| Enough for a single AuthProvider | Missing providers fail only at runtime |
| Required by the task and widely documented | Less compile-time safety than Riverpod |

## Conclusion
For a small login feature, Provider is the right size. If the app grows, for example with attendance sync and many connected states, I would reconsider Riverpod. I do not want to pick a bigger tool before I understand the real problem.