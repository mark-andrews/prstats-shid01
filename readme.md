# Interactive Data Applications with Shiny

This intensive workshop provides a comprehensive introduction to building interactive web applications using R Shiny.
The course focuses on developing fundamental skills and mental models that enable participants to build statistical interfaces and data exploration tools independently.
Rather than surveying the entire Shiny ecosystem superficially, the course takes an incremental approach, building understanding through progressively complex working examples.
Participants learn the reactive programming model that underlies Shiny, how to structure applications effectively, and how to create interactive interfaces to statistical analyses and data visualisations.
The emphasis is on building sufficient foundational competence that participants can continue learning advanced topics independently after the course.

### Topics

**Introduction to Shiny and the Reactive Model**

- What Shiny applications are and how they work
- The three-part structure: user interface definition, server logic, and application binding
- The reactive programming model: how user inputs automatically trigger output updates
- Why Shiny code is structured as nested function calls and how this differs from script-based R
- Building first applications through incremental live coding examples

**Inputs, Outputs, and Layouts**

- Input widgets: sliders, select boxes, radio buttons, text inputs
- Output types: plots, tables, formatted text
- How inputs and outputs connect through ID-based references
- Sidebar layouts, panel structures, and organising multiple interface elements
- Building progressively complex applications with multiple controls and coordinated outputs

**Building Statistical Applications**

- Creating interfaces to statistical analyses and data explorations
- Organising application logic and structuring server code for clarity
- Understanding reactive dependencies: when and why code re-executes
- Structuring computations efficiently to avoid unnecessary re-execution
- Complete applications combining data visualisation, statistical computation, and user interaction

**Advanced Reactivity and Dependencies**

- Dependent inputs: making one input's range or choices depend on another input's value
- Observer patterns and dynamic UI updates
- Multiple linked outputs that share reactive computations
- Debugging reactive applications: understanding reactive flow and diagnosing common errors

**Multi-Panel Applications and Interactive Graphics**

- Tabbed interfaces using tabset panels
- Layouts for applications with multiple coordinated panels
- Selecting regions and individual points in plots
- Coordinated views where interaction in one plot affects another
- Structuring code for larger applications

**Deployment and Moving Forward**

- Deploying applications to shinyapps.io for sharing via web links
- Making applications ready for others to use: titles, instructions, user feedback
- Common error patterns and how to diagnose them
- Resources for continued learning and key topics for further study

### Format

- Hands-on workshop with instructor-led live coding throughout
- Participants code along with the instructor from first principles
- Applications built incrementally from simple to realistic examples
- All examples use statistical analyses and data visualisation applications
- Complete R code and materials provided for independent learning after the course

### Software

Software requirements and installation instructions are in [software.md](software.md).
