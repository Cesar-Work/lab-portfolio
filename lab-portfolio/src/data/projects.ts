export type Project = {
  id: string
  title: string
  year: string
  tags: string[]
  description: string
  repo?: string
  demo?: string
}

export const projects: Project[] = [
  {
    id: 'specimen-01',
    title: 'Empty Spot 1',
    year: '2025',
    tags: ['', '', ''],
    description: '',
    repo: '',
    demo: ''
  },
  {
    id: 'specimen-02',
    title: 'Empty Spot 2',
    year: '2025',
    tags: ['', ''],
    description: '',
    repo: ''
  },
  {
    id: 'specimen-03',
    title: 'Empty Spot 3',
    year: '2025',
    tags: ['', '', ''],
    description: ''
  }
]

