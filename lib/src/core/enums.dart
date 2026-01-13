/// Enum defining slide directions for slide transitions
enum SlideDirection {
  /// Slide from right to left (default)
  fromRight,

  /// Slide from left to right
  fromLeft,

  /// Slide from top to bottom
  fromTop,

  /// Slide from bottom to top
  fromBottom,

  /// Slide from top-right diagonal
  fromTopRight,

  /// Slide from top-left diagonal
  fromTopLeft,

  /// Slide from bottom-right diagonal
  fromBottomRight,

  /// Slide from bottom-left diagonal
  fromBottomLeft,
}

/// Enum defining scale origins for scale transitions
enum ScaleOrigin {
  /// Scale from center (default)
  center,

  /// Scale from top-left corner
  topLeft,

  /// Scale from top-right corner
  topRight,

  /// Scale from bottom-left corner
  bottomLeft,

  /// Scale from bottom-right corner
  bottomRight,

  /// Scale from top center
  topCenter,

  /// Scale from bottom center
  bottomCenter,

  /// Scale from center left
  centerLeft,

  /// Scale from center right
  centerRight,
}

/// Enum defining rotation axis for rotation transitions
enum RotationAxis {
  /// Rotate on Z-axis (2D rotation)
  z,

  /// Rotate on X-axis (flip horizontal)
  x,

  /// Rotate on Y-axis (flip vertical)
  y,
}

/// Enum defining expand directions for size transitions
enum ExpandDirection {
  /// Expand horizontally
  horizontal,

  /// Expand vertically
  vertical,

  /// Expand from center in all directions
  center,
}

/// Enum defining shared axis direction for Material transitions
enum SharedAxisDirection {
  /// Horizontal axis (X)
  horizontal,

  /// Vertical axis (Y)
  vertical,

  /// Depth axis (Z)
  scaled,
}

/// Enum defining cube rotation directions
enum CubeRotation {
  /// Rotate horizontally
  horizontal,

  /// Rotate vertically
  vertical,
}

/// Enum defining directional transition variants
enum DirectionalVariant {
  /// New page pushes old page
  push,

  /// New page slides over old page
  cover,

  /// Old page slides away revealing new page
  reveal,

  /// Both pages move at different speeds
  parallax,
}

/// Enum defining wipe shapes for masked transitions
enum WipeShape {
  /// Circle wipe
  circle,

  /// Diamond wipe
  diamond,

  /// Star shape
  star,

  /// Heart shape
  heart,

  /// Horizontal wipe
  horizontal,

  /// Vertical wipe
  vertical,

  /// Diagonal wipe
  diagonal,
}

/// Enum defining transition styles
enum TransitionStyle {
  /// Elegant and subtle transitions
  elegant,

  /// Playful and bouncy transitions
  playful,

  /// Professional and clean transitions
  professional,

  /// Gaming-style dramatic transitions
  gaming,

  /// Minimal and fast transitions
  minimal,
}

/// Enum defining physics types for physics-based transitions
enum PhysicsType {
  /// Spring physics with bounce
  spring,

  /// Gravity-based drop
  gravity,

  /// Elastic bounce
  elastic,

  /// Damped oscillation
  damped,

  /// Inertia with friction
  inertia,
}
